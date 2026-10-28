import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class _Text extends StatelessWidget {
  const _Text(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Scaffold(body: Text(text));
}

class _DetailScreen extends StatelessWidget {
  const _DetailScreen();
  @override
  Widget build(BuildContext context) => const Scaffold(body: NestedRouter());
}

class _TestRouter extends RootStackRouter {
  @override
  late final Map<String, PageFactory> pagesMap = {
    'HomeRoute': (d) => MaterialPageX(routeData: d, child: const _Text('Home')),
    'DetailRoute': (d) =>
        MaterialPageX(routeData: d, child: const _DetailScreen()),
    'InnerRoute': (d) =>
        MaterialPageX(routeData: d, child: const _Text('Inner')),
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('HomeRoute', path: '/', fullMatch: true),
        RouteConfig('DetailRoute', path: '/detail/:id', children: [
          RouteConfig('InnerRoute', path: '', fullMatch: true),
        ]),
      ];
}

PageRouteInfo _detail(int id) => PageRouteInfo<int>(
      'DetailRoute',
      path: '/detail/$id',
      args: id,
      rawPathParams: {'id': id},
      initialChildren: const [PageRouteInfo('InnerRoute', path: '')],
    );

void main() {
  testWidgets(
    'popping a page keeps the nested router of a sibling page from the same route',
    (tester) async {
      final router = _TestRouter();
      await tester.pumpWidget(MaterialApp.router(
        routerDelegate: router.delegate(
          initialRoutes: [const PageRouteInfo('HomeRoute', path: '/')],
        ),
        routeInformationParser: router.defaultRouteParser(),
        routeInformationProvider: router.routeInfoProvider(),
      ));
      await tester.pumpAndSettle();

      unawaited(router.push(_detail(1)));
      await tester.pumpAndSettle();
      unawaited(router.push(_detail(2)));
      await tester.pumpAndSettle();
      expect(router.stack, hasLength(3));
      expect(router.childControllers, hasLength(2));

      unawaited(router.pop());
      await tester.pumpAndSettle();

      expect(router.stack, hasLength(2));
      expect(router.childControllers, hasLength(1));
      expect(router.childControllers.single.routeData.args, 1);
      expect(router.innerRouterOf('DetailRoute'), isNotNull);
    },
  );
}
