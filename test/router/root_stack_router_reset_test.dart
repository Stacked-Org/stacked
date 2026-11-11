import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class _TestRouter extends RootStackRouter {
  @override
  final Map<String, PageFactory> pagesMap = {
    'Home': (data) => CustomPage<dynamic>(
          routeData: data,
          child: const Text('home'),
        ),
    'About': (data) => CustomPage<dynamic>(
          routeData: data,
          child: const Text('about'),
        ),
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('Home', path: '/'),
        RouteConfig('About', path: '/about'),
      ];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<_TestRouter> bootedRouter(WidgetTester tester) async {
    final router = _TestRouter();
    await tester.pumpWidget(MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
    ));
    await tester.pumpAndSettle();
    return router;
  }

  group('RootStackRouter.resetAll -', () {
    testWidgets('clears the stack and history of a used router',
        (tester) async {
      final router = await bootedRouter(tester);
      unawaited(router.push(const PageRouteInfo('About', path: '/about')));
      await tester.pumpAndSettle();
      expect(router.stack.map((p) => p.routeData.name), ['Home', 'About']);
      expect(router.currentPath, '/about');

      RootStackRouter.resetAll();

      expect(router.hasEntries, isFalse);
      expect(router.urlState.hasSegments, isFalse);
      expect(router.navigationHistory.length, 0);
    });

    testWidgets('lets the same router boot a new app from the start',
        (tester) async {
      final router = _TestRouter();
      Widget app() => MaterialApp.router(
            routerDelegate: router.delegate(),
            routeInformationParser: router.defaultRouteParser(),
          );

      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      unawaited(router.push(const PageRouteInfo('About', path: '/about')));
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox());

      RootStackRouter.resetAll();
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      expect(router.stack.map((p) => p.routeData.name), ['Home']);
      expect(find.text('home'), findsOneWidget);
    });

    testWidgets('keeps the stack when it is not called', (tester) async {
      final router = await bootedRouter(tester);
      unawaited(router.push(const PageRouteInfo('About', path: '/about')));
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox());

      await tester.pumpWidget(MaterialApp.router(
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
      ));
      await tester.pumpAndSettle();

      expect(router.stack.map((p) => p.routeData.name), ['Home', 'About']);
    });
  });
}
