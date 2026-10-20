// Regression tests for removing a popped/replaced page by identity rather
// than by routeKey. Two pages pushed from the same route (e.g. the same
// DetailRoute with different args) share a routeKey, so a key-based removal
// can remove the wrong (sibling) page.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Home'));
}

class _DetailScreen extends StatelessWidget {
  const _DetailScreen();

  @override
  Widget build(BuildContext context) {
    final id = RouteData.of(context).argsAs<int>();
    return Scaffold(body: Text('Detail $id'));
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Settings'));
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Login'));
}

class _SearchScreen extends StatelessWidget {
  const _SearchScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('Search'));
}

class _TestRouter extends RootStackRouter {
  @override
  late final Map<String, PageFactory> pagesMap = {
    'HomeRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _HomeScreen(),
        ),
    'DetailRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _DetailScreen(),
        ),
    'SettingsRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _SettingsScreen(),
        ),
    'LoginRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _LoginScreen(),
        ),
    'SearchRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _SearchScreen(),
        ),
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('HomeRoute', path: '/', fullMatch: true),
        RouteConfig('DetailRoute', path: '/detail/:id'),
        RouteConfig('SettingsRoute', path: '/settings'),
        RouteConfig('LoginRoute', path: '/login'),
        RouteConfig('SearchRoute', path: '/search'),
      ];
}

Future<_TestRouter> _pumpRouter(
  WidgetTester tester, {
  required List<PageRouteInfo> initialRoutes,
}) async {
  final router = _TestRouter();
  await tester.pumpWidget(
    MaterialApp.router(
      routerDelegate: router.delegate(initialRoutes: initialRoutes),
      routeInformationParser: router.defaultRouteParser(),
      routeInformationProvider: router.routeInfoProvider(),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

PageRouteInfo _detailRoute(int id) => PageRouteInfo<int>(
      'DetailRoute',
      path: '/detail/$id',
      args: id,
      rawPathParams: {'id': id},
    );

void main() {
  testWidgets(
    'popping the top of two same-key pages only removes the top one '
    '(regression test for sibling removal by shared routeKey)',
    (tester) async {
      final router = await _pumpRouter(
        tester,
        initialRoutes: [const PageRouteInfo('HomeRoute', path: '/')],
      );

      unawaited(router.push(_detailRoute(1)));
      await tester.pumpAndSettle();
      unawaited(router.push(_detailRoute(2)));
      await tester.pumpAndSettle();

      expect(router.stack, hasLength(3));
      expect(find.text('Detail 2'), findsOneWidget);

      // Both Detail pages share the default key (ValueKey('DetailRoute')).
      expect(router.stack[1].routeKey, equals(router.stack[2].routeKey));

      unawaited(router.pop());
      await tester.pumpAndSettle();

      expect(router.stack, hasLength(2));
      expect(
        router.stack.map((p) => p.routeData.name),
        ['HomeRoute', 'DetailRoute'],
      );
      expect(router.stack.last.routeData.args, equals(1));
      expect(find.text('Detail 1'), findsOneWidget);
      expect(find.text('Detail 2'), findsNothing);
      expect(find.text('Home'), findsNothing);
    },
  );

  testWidgets(
    'replacing the top of two same-key pages keeps the other one '
    '(regression test for sibling removal by shared routeKey)',
    (tester) async {
      final router = await _pumpRouter(
        tester,
        initialRoutes: [const PageRouteInfo('HomeRoute', path: '/')],
      );

      unawaited(router.push(_detailRoute(1)));
      await tester.pumpAndSettle();
      unawaited(router.push(_detailRoute(2)));
      await tester.pumpAndSettle();

      expect(router.stack, hasLength(3));
      final detail1Page = router.stack[1];

      unawaited(
        router.replace(const PageRouteInfo('SettingsRoute', path: '/settings')),
      );
      await tester.pumpAndSettle();

      // Detail(1) must survive: same page instance, still holding args: 1.
      // (Buried pages aren't found by `find.text` - skipOffstage treats the
      // previous route's faded-out layer as offstage - so the stack itself,
      // not the widget tree, is what this asserts on.)
      expect(
        router.stack.map((p) => p.routeData.name),
        ['HomeRoute', 'DetailRoute', 'SettingsRoute'],
      );
      expect(router.stack[1], same(detail1Page));
      expect(router.stack[1].routeData.args, equals(1));
      expect(find.text('Settings'), findsOneWidget);
    },
  );

  testWidgets(
    'query params set by a replace survive the disposal of the replaced page',
    (tester) async {
      final router = await _pumpRouter(
        tester,
        initialRoutes: [const PageRouteInfo('LoginRoute', path: '/login')],
      );

      expect(router.stack, hasLength(1));

      unawaited(
        router.replace(
          const PageRouteInfo(
            'SearchRoute',
            path: '/search',
            rawQueryParams: {'q': 'x'},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(router.stack, hasLength(1));
      expect(router.stack.single.routeData.name, 'SearchRoute');
      expect(router.stack.single.routeData.queryParams.rawMap['q'], 'x');
      expect(router.currentUrl, contains('q=x'));
    },
  );
}
