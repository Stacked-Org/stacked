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

class _InnerHomeScreen extends StatelessWidget {
  const _InnerHomeScreen();

  @override
  Widget build(BuildContext context) => const Text('InnerHome');
}

class _NestedHost extends StatefulWidget {
  const _NestedHost({
    required this.triggerRemoval,
    required this.onNestedRouterReady,
  });

  final ValueListenable<bool> triggerRemoval;
  final ValueChanged<StackRouter> onNestedRouterReady;

  @override
  State<_NestedHost> createState() => _NestedHostState();
}

class _NestedHostState extends State<_NestedHost> {
  bool _unmounted = false;
  StackRouter? _nestedRouter;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.triggerRemoval,
      builder: (context, _) {
        if (widget.triggerRemoval.value && !_unmounted) {
          _unmounted = true;
          final nested = _nestedRouter!;
          if (nested.stack.isNotEmpty) {
            nested.removeRoute(nested.stack.last.routeData);
          }
        }
        if (_unmounted) {
          return const SizedBox.shrink();
        }
        return NestedRouter(
          builder: (ctx, child) {
            if (_nestedRouter == null) {
              _nestedRouter = NestedRouter.of(ctx);
              widget.onNestedRouterReady(_nestedRouter!);
            }
            return child;
          },
        );
      },
    );
  }
}

class _ParentScreen extends StatelessWidget {
  const _ParentScreen({
    required this.triggerRemoval,
    required this.onNestedRouterReady,
  });

  final ValueListenable<bool> triggerRemoval;
  final ValueChanged<StackRouter> onNestedRouterReady;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _NestedHost(
        triggerRemoval: triggerRemoval,
        onNestedRouterReady: onNestedRouterReady,
      ),
    );
  }
}

class _DisposeTestRouter extends RootStackRouter {
  _DisposeTestRouter(this.triggerRemoval, this.onNestedRouterReady);

  final ValueListenable<bool> triggerRemoval;
  final ValueChanged<StackRouter> onNestedRouterReady;

  @override
  late final Map<String, PageFactory> pagesMap = {
    'HomeRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _HomeScreen(),
        ),
    'ParentRoute': (data) => MaterialPageX(
          routeData: data,
          child: _ParentScreen(
            triggerRemoval: triggerRemoval,
            onNestedRouterReady: onNestedRouterReady,
          ),
        ),
    'InnerHomeRoute': (data) => MaterialPageX(
          routeData: data,
          child: const _InnerHomeScreen(),
        ),
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('HomeRoute', path: '/', fullMatch: true),
        RouteConfig(
          'ParentRoute',
          path: '/parent',
          fullMatch: true,
          children: [
            RouteConfig('InnerHomeRoute', path: '/inner-home', fullMatch: true),
          ],
        ),
      ];
}

void main() {
  testWidgets(
    'a deferred notifyAll scheduled for a nested router does not throw '
    'when that router is disposed before the frame ends',
    (tester) async {
      final triggerRemoval = ValueNotifier<bool>(false);
      addTearDown(triggerRemoval.dispose);
      StackRouter? nestedRouter;

      final router = _DisposeTestRouter(
        triggerRemoval,
        (r) => nestedRouter = r,
      );

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
        router.push(const PageRouteInfo('ParentRoute', path: '/parent')),
      );
      await tester.pumpAndSettle();

      expect(nestedRouter, isNotNull);
      unawaited(
        nestedRouter!
            .push(const PageRouteInfo('InnerHomeRoute', path: '/inner-home')),
      );
      await tester.pumpAndSettle();

      expect(find.text('InnerHome'), findsOneWidget);
      expect(nestedRouter!.stack, hasLength(1));

      triggerRemoval.value = true;
      await tester.pump();

      expect(tester.takeException(), isNull);

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(router.currentSegments.map((e) => e.name), ['ParentRoute']);
      expect(router.navigationHistory.urlState.path, '/parent');
    },
  );
}
