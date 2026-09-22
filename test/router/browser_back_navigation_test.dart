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

      unawaited(
        router.push(const PageRouteInfo('SecondRoute', path: '/second')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Second'), findsOneWidget);
      expect(router.stack, hasLength(2));

      triggerRemoval.value = true;
      router.notifyListeners();
      await tester.pump();

      expect(tester.takeException(), isNull);

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

      await tester.binding.handlePopRoute();

      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
        expect(tester.takeException(), isNull);
      }
      await tester.pumpAndSettle();
      expect(find.text('Second'), findsNothing);
      expect(router.stack, hasLength(1));
    },
  );
}
