import 'dart:math';

import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/router/router_class_generator.dart';
import 'package:test/test.dart';

import '../helpers/router_constants.dart';

void main() {
  group('RouteClassGeneratorTest -', () {
    void callGeneratorWithServicesConfigAndExpectException<T>(
        List<RouteConfig> routes,
        [String? exceptionMessage]) {
      final routerBaseGenerator =
          RouterClassGenerator(RouterConfig(routes: routes));
      expect(
        () => routerBaseGenerator.generate(),
        throwsA(predicate<dynamic>((e) => e is T && exceptionMessage == null
            ? true
            : e.message == exceptionMessage)),
      );
    }

    group('default router -', () {
      test('When className is null, Throw exception', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
        ];
        callGeneratorWithServicesConfigAndExpectException<
                InvalidGeneratorInputException>(
            routes, ExceptionMessages.RouteClassNameShouldnotBeNull);
      });
      test('Given the following RouteConfig, Generate output', () {
        final routerBaseGenerator = RouterClassGenerator(RouterConfig(routes: [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
        ]));

        expect(
            routerBaseGenerator.generate(), kRouterWithNamePathNameClassName);
      });
      test('''
When routeType is material, 
(cupertinoNavTitle customRouteBarrierDismissible durationInMilliseconds) doesnot have any effect''',
          () {
        final routerBaseGenerator = RouterClassGenerator(RouterConfig(routes: [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..cupertinoNavTitle = 'cupertinooo'
            ..customRouteBarrierDismissible = true
            ..durationInMilliseconds = 22
        ]));

        expect(
            routerBaseGenerator.generate(), kRouterWithNamePathNameClassName);
      });

      test('When fullscreenDialog is true', () {
        final routerBaseGenerator = RouterClassGenerator(RouterConfig(routes: [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..fullscreenDialog = true
        ]));

        expect(routerBaseGenerator.generate(),
            kRouterWithNamePathNameClassNameFullScreenDialogIsTrue);
      });
      test('When fullscreenDialog is false', () {
        final routerBaseGenerator = RouterClassGenerator(RouterConfig(routes: [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..fullscreenDialog = false
        ]));

        expect(routerBaseGenerator.generate(),
            kRouterWithNamePathNameClassNameFullScreenDialogIsFalse);
      });
      test('When adding one RouteGuardConfig', () {
        final routerBaseGenerator = RouterClassGenerator(RouterConfig(routes: [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..guards = [
              RouteGuardConfig(import: 'guard/import.dart', type: 'GuardType')
            ]
        ]));

        expect(routerBaseGenerator.generate(), kRouterWithOneGuard);
      });
      test('When adding two RouteGuardConfig', () {
        final routerBaseGenerator = RouterClassGenerator(RouterConfig(routes: [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..guards = [
              RouteGuardConfig(
                import: 'guard/import.dart',
                type: 'GuardType',
              ),
              RouteGuardConfig(
                import: 'guard/import2.dart',
                type: 'GuardType2?',
              ),
            ]
        ]));

        expect(routerBaseGenerator.generate(), kRouterWithTwoGuards);
      });
    });
  });
}
