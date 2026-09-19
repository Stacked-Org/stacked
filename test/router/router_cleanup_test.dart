import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Home'));
}

class _GuardedScreen extends StatelessWidget {
  const _GuardedScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Guarded'));
}

class _ElsewhereScreen extends StatelessWidget {
  const _ElsewhereScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Elsewhere'));
}

/// Always allows navigation; exposes [hasActiveListeners] so the test can
/// observe whether a router still holds a listener on this guard.
class _AllowGuard extends RedirectGuard {
  bool allow = true;

  @override
  Future<bool> canNavigate(RouteMatch route) async => allow;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(allow);
  }

  bool get hasActiveListeners => hasListeners;
}

class _GuardTestRouter extends RootStackRouter {
  _GuardTestRouter(this.guard);

  final _AllowGuard guard;

  @override
  late final Map<String, PageFactory> pagesMap = {
    'HomeRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _HomeScreen(),
        ),
    'GuardedRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _GuardedScreen(),
        ),
    'ElsewhereRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _ElsewhereScreen(),
        ),
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('HomeRoute', path: '/', fullMatch: true),
        RouteConfig(
          'GuardedRoute',
          path: '/guarded',
          fullMatch: true,
          guards: [guard],
        ),
        RouteConfig('ElsewhereRoute', path: '/elsewhere', fullMatch: true),
      ];
}

void main() {
  testWidgets(
    'a redirect guard listener is detached even when its page was already '
    'taken out of _pages directly (e.g. removeWhere) before removeRoute '
    'runs',
    (tester) async {
      final guard = _AllowGuard();
      addTearDown(guard.dispose);
      final router = _GuardTestRouter(guard);

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

      // push()'s Future only resolves when the page is popped, which this
      // test never does directly -- so it must not be awaited (see the
      // existing browser-back tests in this directory for the same idiom).
      unawaited(
        router.push(const PageRouteInfo('GuardedRoute', path: '/guarded')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Guarded'), findsOneWidget);
      expect(router.stack, hasLength(2));
      expect(guard.hasActiveListeners, isTrue);

      final guardedPageData = router.stack.last.routeData;

      // Take the page out of `_pages` directly, the way removeWhere/_reset/
      // updateDeclarativeRoutes do -- bypassing _removeRoute entirely. This
      // notifies (as removeWhere normally does), so the UI catches up.
      router.removeWhere((r) => r.name == 'GuardedRoute');
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Guarded'), findsNothing);

      // The Navigator later notices the page is gone from the pages list it
      // was given and calls back into removeRoute; by now the page is
      // already missing from `_pages`, so this hits the pageIndex == -1
      // branch under test.
      router.removeRoute(guardedPageData);
      await tester.pump();

      expect(
        guard.hasActiveListeners,
        isFalse,
        reason: 'the RedirectGuard listener should be detached even when '
            'the page was already removed from _pages',
      );

      // Observable consequence of a leaked listener: a later guard
      // re-evaluation must not resurrect navigation on a router the user
      // already navigated away from.
      guard.reevaluate(
        strategy: ReevaluationStrategy.removeAllAndPush(
          const PageRouteInfo('ElsewhereRoute', path: '/elsewhere'),
        ),
      );
      await tester.pumpAndSettle();

      expect(router.stack, hasLength(1));
      expect(router.stack.single.routeKey, const ValueKey('HomeRoute'));
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Elsewhere'), findsNothing);
    },
  );
}
