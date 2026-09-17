import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:stacked/src/router/matcher/route_match.dart';
import 'package:stacked/src/router/stacked_page.dart';

/// Minimal stand-in for [RoutingController].
///
/// [RoutingController] is abstract and pulls in the whole routing stack, but
/// [RouteData] only stores the reference without calling anything on it
/// during the scenario under test, so a `noSuchMethod`-backed fake is enough.
class _FakeRoutingController implements RoutingController {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Records a single call made to [_FakeStackRouter.removeRoute].
class _RemoveRouteCall {
  const _RemoveRouteCall(this.route, {required this.notify});
  final RouteData route;
  final bool notify;
}

/// A [StackRouter] test double that records calls to [removeRoute] instead
/// of actually maintaining a page stack.
///
/// Standing up a real [StackRouter] would require a full route
/// collection/matcher/page-builder setup unrelated to what's under test
/// here: whether [StackedPage.createRoute] asks the router to remove the
/// page eagerly, with the right arguments, only for the route that actually
/// popped.
class _FakeStackRouter implements StackRouter {
  final List<_RemoveRouteCall> removeRouteCalls = [];

  @override
  void removeRoute(RouteData route, {bool notify = true}) {
    removeRouteCalls.add(_RemoveRouteCall(route, notify: notify));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A bare-bones [Route] with none of [PageRoute]'s animation-controller
/// machinery, so tests can drive [didPop]/[didComplete] directly without
/// installing the route into a real [Navigator].
class _TestRoute<T> extends Route<T> {
  _TestRoute({required RouteSettings settings}) : super(settings: settings);
}

/// A minimal concrete [StackedPage] used purely to exercise `createRoute`.
class _TestPage<T> extends StackedPage<T> {
  _TestPage({required super.routeData, required super.child});

  @override
  Route<T> onCreateRoute(BuildContext context) => _TestRoute<T>(settings: this);
}

RouteData _buildRouteData(String name, {RoutingController? router}) {
  final match = RouteMatch(
    name: name,
    segments: [name],
    path: '/$name',
    stringMatch: '/$name',
    key: ValueKey(name),
  );
  return RouteData(
    route: match,
    router: router ?? _FakeRoutingController(),
    pendingChildren: const [],
  );
}

void main() {
  group('StackedPage', () {
    testWidgets(
      'createRoute called twice on the same page instance does not complete '
      'popped twice (regression test for #1181)',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: SizedBox()));
        final context = tester.element(find.byType(SizedBox));

        final page = _TestPage<String>(
          routeData: _buildRouteData('test'),
          child: const SizedBox(),
        );

        // Flutter's Navigator can call createRoute more than once for the
        // same Page instance (e.g. page reuse during a predictive back
        // gesture that gets recreated/cancelled). Simulate that here.
        final routeA = page.createRoute(context);
        final routeB = page.createRoute(context);

        expect(routeA, isNot(same(routeB)));

        // Completing the stale (first) route must not throw, and must not
        // be the value that resolves `popped`.
        expect(() => routeA.didPop('stale-result'), returnsNormally);

        // Completing the real (latest) route must also not throw, even
        // though the stale route already completed above. Before the fix,
        // this would throw "Bad state: Future already completed".
        expect(() => routeB.didPop('latest-result'), returnsNormally);

        // Only the latest route's result should ever be forwarded.
        await expectLater(page.popped, completion('latest-result'));
      },
    );

    testWidgets(
      'createRoute called once still forwards the pop result as before',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: SizedBox()));
        final context = tester.element(find.byType(SizedBox));

        final page = _TestPage<String>(
          routeData: _buildRouteData('single'),
          child: const SizedBox(),
        );

        final route = page.createRoute(context);
        route.didPop('the-result');

        await expectLater(page.popped, completion('the-result'));
      },
    );

    testWidgets(
      'completing the stale route after the latest route already completed '
      'does not throw',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: SizedBox()));
        final context = tester.element(find.byType(SizedBox));

        final page = _TestPage<String>(
          routeData: _buildRouteData('reverse-order'),
          child: const SizedBox(),
        );

        final routeA = page.createRoute(context);
        final routeB = page.createRoute(context);

        // Complete the latest route first this time.
        routeB.didPop('latest-result');
        expect(() => routeA.didPop('stale-result'), returnsNormally);

        await expectLater(page.popped, completion('latest-result'));
      },
    );

    testWidgets(
      'popping the route eagerly removes the page from the router stack, '
      'without waiting for onDidRemovePage (regression test for the '
      'phantom-Route/forward-flash glitch; approach based on #1188 by '
      '@Vinsho)',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: SizedBox()));
        final context = tester.element(find.byType(SizedBox));

        final router = _FakeStackRouter();
        final routeData = _buildRouteData('predictive-back', router: router);
        final page = _TestPage<String>(
          routeData: routeData,
          child: const SizedBox(),
        );

        final route = page.createRoute(context);
        route.didPop('the-result');

        // Nothing resembling RouteNavigator's `onDidRemovePage` callback is
        // ever invoked in this test, yet the router must already have been
        // asked to remove the page by the time `popped` resolves.
        await expectLater(page.popped, completion('the-result'));

        expect(router.removeRouteCalls, hasLength(1));
        expect(router.removeRouteCalls.single.route, same(routeData));
        expect(router.removeRouteCalls.single.notify, isTrue);
      },
    );

    testWidgets(
      'createRoute called twice only removes the page from the router once, '
      'for the latest route, and not for the stale one',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: SizedBox()));
        final context = tester.element(find.byType(SizedBox));

        final router = _FakeStackRouter();
        final routeData = _buildRouteData('predictive-back-2', router: router);
        final page = _TestPage<String>(
          routeData: routeData,
          child: const SizedBox(),
        );

        final routeA = page.createRoute(context);
        final routeB = page.createRoute(context);

        // The stale route popping first must not touch the router at all.
        routeA.didPop('stale-result');
        await Future<void>.value();
        expect(router.removeRouteCalls, isEmpty);

        // The latest (real) route popping removes the page exactly once.
        routeB.didPop('latest-result');
        await expectLater(page.popped, completion('latest-result'));

        expect(router.removeRouteCalls, hasLength(1));
        expect(router.removeRouteCalls.single.route, same(routeData));
        expect(router.removeRouteCalls.single.notify, isTrue);
      },
    );
  });
}
