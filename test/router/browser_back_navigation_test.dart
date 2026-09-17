// Regression test for https://github.com/Stacked-Org/stacked/issues/1184
// "setState() called during build - Exception on Browser Back Navigation".
//
// Root cause: `RouteNavigator`'s `onDidRemovePage` callback (and any other
// caller of `StackRouter.removeRoute`, such as `StackedPage.popped`) ends up
// calling `RoutingController._removeRoute`, which used to *unconditionally*
// notify listeners - even when the page had already been removed from the
// stack by another code path (nothing to do, nothing changed) and even when
// this happened to run *during* a build/update of the router's own widget
// tree. A browser/system back navigation can trigger exactly that: it can
// remove a page while `_RootRouter` (the router's own `StatefulWidget`) is
// itself in the middle of rebuilding, because a descendant deep in its
// subtree (the page being popped, or anything listening to the router) gets
// rebuilt *as part of* `_RootRouter`'s own rebuild cascade. Synchronously
// calling `notifyListeners()` at that point calls
// `_RootRouterState.setState()` on a widget that is still on the build call
// stack, which throws "setState() or markNeedsBuild() called during build" -
// matching the reported stack trace (`route_navigator.dart` -> `removeRoute`
// -> `notifyAll` -> `notifyListeners` -> `nested_router_delegate.dart`
// `_handleRebuild` -> `setState`, all nested inside a chain of `update` /
// `performRebuild` calls).
//
// The fix (in `RoutingController._removeRoute`) makes the removal
// idempotent (a page that's no longer on the stack is a no-op, nothing to
// notify) and, when a removal *does* happen while the scheduler is in the
// `persistentCallbacks` (build) phase, defers the listener notification to
// a post-frame callback instead of dispatching it synchronously.
//
// Two things are exercised here:
//  * A test that forces `removeRoute` to run for the current top page from
//    a `ListenableBuilder` nested inside that very page, driven by the
//    router's own `notifyListeners()` - so the removal happens while
//    `_RootRouter` is genuinely still on the build call stack (its own
//    rebuild cascades down into this descendant in the same pass) - and
//    asserts no exception is thrown.
//  * A best-effort end-to-end test that drives a real system/browser-style
//    pop via `WidgetsBinding.instance.handlePopRoute()` (the callback the
//    engine invokes for a back-button press) and asserts no exception.
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Home'));
}

/// The "second" screen. When [triggerRemoval] flips to `true`, the next
/// time the router notifies its listeners, this widget removes *itself*
/// from the router's stack from directly inside its own `build()` method -
/// i.e. while it is being rebuilt as a descendant of `_RootRouter`, which is
/// itself still on the call stack rebuilding because of that very
/// notification.
class _SecondScreen extends StatelessWidget {
  const _SecondScreen({required this.router, required this.triggerRemoval});

  final StackRouter router;
  final ValueListenable<bool> triggerRemoval;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([router, triggerRemoval]),
      builder: (context, _) {
        if (triggerRemoval.value) {
          final topPage = router.stack.last;
          if (topPage.routeKey == const ValueKey('SecondRoute')) {
            router.removeRoute(topPage.routeData);
          }
        }
        return const Scaffold(body: Text('Second'));
      },
    );
  }
}

class _TestRouter extends RootStackRouter {
  _TestRouter(this.triggerRemoval);

  final ValueListenable<bool> triggerRemoval;

  @override
  late final Map<String, PageFactory> pagesMap = {
    'HomeRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _HomeScreen(),
        ),
    'SecondRoute': (data) => MaterialPageX(
          routeData: data,
          child: _SecondScreen(router: this, triggerRemoval: triggerRemoval),
        ),
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('HomeRoute', path: '/', fullMatch: true),
        RouteConfig('SecondRoute', path: '/second', fullMatch: true),
      ];
}

void main() {
  testWidgets(
    'removing the current top page from a descendant rebuilt while the '
    'router widget is itself rebuilding does not throw "setState() called '
    'during build"',
    (tester) async {
      final triggerRemoval = ValueNotifier<bool>(false);
      final router = _TestRouter(triggerRemoval);
      addTearDown(triggerRemoval.dispose);

      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: router.delegate(
            initialRoutes: [
              const PageRouteInfo('HomeRoute', path: '/'),
            ],
          ),
          routeInformationParser: router.defaultRouteParser(),
          routeInformationProvider: router.routeInfoProvider(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);

      // Push a second route, mimicking `RouterService.navigateTo(...)`.
      //
      // Note: `push` returns a Future that only completes once the pushed
      // page is popped (it mirrors `Navigator.push`'s "return a result on
      // pop" contract), so it must not be awaited here.
      unawaited(
        router.push(const PageRouteInfo('SecondRoute', path: '/second')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Second'), findsOneWidget);
      expect(router.stack, hasLength(2));

      // Arm the trigger, then notify the router's own listeners directly -
      // the same signal `_removeRoute`'s `notifyAll()` sends. This marks
      // `_RootRouter` dirty *and* (via the `ListenableBuilder` inside
      // `_SecondScreen`, which also listens to the router) marks the
      // second page's own subtree dirty. Both get rebuilt in the same
      // top-down pass: `_RootRouter` first (an ancestor), and while its
      // rebuild is still cascading down into its descendants, the
      // `ListenableBuilder` removes the page from directly inside that
      // descendant's `build()`.
      triggerRemoval.value = true;
      router.notifyListeners();
      await tester.pump();

      // Before the fix, this synchronously called `notifyAll()` ->
      // `notifyListeners()` -> `setState()` on `_RootRouter` while it was
      // still on the build call stack, throwing "setState() or
      // markNeedsBuild() called during build" right here.
      expect(tester.takeException(), isNull);

      // The notification (and the rebuild it schedules) is deferred to a
      // post-frame callback, so let the app settle before asserting on the
      // final state.
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Second'), findsNothing);
      expect(router.stack, hasLength(1));
    },
  );

  testWidgets(
    'a real system/browser back navigation does not throw '
    '"setState() called during build"',
    (tester) async {
      final triggerRemoval = ValueNotifier<bool>(false);
      final router = _TestRouter(triggerRemoval);
      addTearDown(triggerRemoval.dispose);

      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: router.delegate(
            initialRoutes: [
              const PageRouteInfo('HomeRoute', path: '/'),
            ],
          ),
          routeInformationParser: router.defaultRouteParser(),
          routeInformationProvider: router.routeInfoProvider(),
        ),
      );
      await tester.pumpAndSettle();

      unawaited(
        router.push(const PageRouteInfo('SecondRoute', path: '/second')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Second'), findsOneWidget);

      // Simulate a system/browser back navigation: this is the same
      // `WidgetsBindingObserver` callback the engine invokes for a hardware
      // back-button press (Android) or a browser back-button press, and it
      // drives `Router.didPopRoute` -> `NestedRouterDelegate.popRoute` ->
      // `controller.topMostRouter().pop()` -> the real, imperative
      // `NavigatorState.maybePop()` -> (eventually) `onDidRemovePage`.
      await tester.binding.handlePopRoute();

      // Pump a bounded number of frames (rather than `pumpAndSettle`, which
      // keeps pumping for up to 10 minutes) and make sure none of them
      // throws.
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
        expect(tester.takeException(), isNull);
      }
    },
  );
}
