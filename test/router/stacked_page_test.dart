import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:stacked/src/router/matcher/route_match.dart';
import 'package:stacked/src/router/stacked_page.dart';

class _FakeRoutingController implements RoutingController {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RemovePageInstanceCall {
  const _RemovePageInstanceCall(this.page, {required this.notify});
  final StackedPage page;
  final bool notify;
}

class _FakeStackRouter implements StackRouter {
  final List<_RemovePageInstanceCall> removePageInstanceCalls = [];

  @override
  List<StackedPage> stack = [];

  @override
  bool removePageInstance(StackedPage page, {bool notify = true}) {
    removePageInstanceCalls.add(_RemovePageInstanceCall(page, notify: notify));
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _TestRoute<T> extends Route<T> {
  _TestRoute({required RouteSettings settings}) : super(settings: settings);
}

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

        final routeA = page.createRoute(context);
        final routeB = page.createRoute(context);

        expect(routeA, isNot(same(routeB)));

        expect(() => routeA.didPop('stale-result'), returnsNormally);

        expect(() => routeB.didPop('latest-result'), returnsNormally);

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
        router.stack = [page, page];

        final route = page.createRoute(context);
        route.didPop('the-result');

        await expectLater(page.popped, completion('the-result'));

        expect(router.removePageInstanceCalls, hasLength(1));
        expect(router.removePageInstanceCalls.single.page, same(page));
        expect(router.removePageInstanceCalls.single.notify, isTrue);
      },
    );

    testWidgets(
      'popping the last page does not eagerly remove it, so the Navigator '
      'stays mounted during the exit animation',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: SizedBox()));
        final context = tester.element(find.byType(SizedBox));

        final router = _FakeStackRouter();
        final routeData = _buildRouteData('last-page', router: router);
        final page = _TestPage<String>(
          routeData: routeData,
          child: const SizedBox(),
        );
        router.stack = [page];

        final route = page.createRoute(context);
        route.didPop('the-result');

        await expectLater(page.popped, completion('the-result'));
        expect(router.removePageInstanceCalls, isEmpty);
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
        router.stack = [page, page];

        final routeA = page.createRoute(context);
        final routeB = page.createRoute(context);

        routeA.didPop('stale-result');
        await Future<void>.value();
        expect(router.removePageInstanceCalls, isEmpty);

        routeB.didPop('latest-result');
        await expectLater(page.popped, completion('latest-result'));

        expect(router.removePageInstanceCalls, hasLength(1));
        expect(router.removePageInstanceCalls.single.page, same(page));
        expect(router.removePageInstanceCalls.single.notify, isTrue);
      },
    );
  });
}
