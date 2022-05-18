import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/router/router_class_generator.dart';
import 'package:test/test.dart';

import '../helpers/router_constants.dart';

void main() {
  group('RouteClassGeneratorTest -', () {
    void generateRoutesAndExpectException<T>(List<RouteConfig> routes,
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

    void generateRouteAndExpectResult(
        List<RouteConfig> routes, dynamic expectedResult,
        {bool verbose = false}) {
      final routerBaseGenerator = RouterClassGenerator(RouterConfig(
          routesClassName: 'RoutesClassB',
          routerClassName: 'RouterNamee',
          routes: routes));
      if (verbose) print(routerBaseGenerator.generate());
      expect(routerBaseGenerator.generate(), expectedResult);
    }

    group('RouteType.material - default -', () {
      test('When routes are empty', () {
        List<RouteConfig> routes = [];

        generateRouteAndExpectResult(
          routes,
          kRouterWithEmptyRoutes,
        );
      });
      test('When RouteConfig -> className is null, Throw exception', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
        ];
        generateRoutesAndExpectException<InvalidGeneratorInputException>(
            routes, ExceptionMessages.RouteClassNameShouldnotBeNull);
      });
      test('Given the following RouteConfig, Generate output', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
        ];

        generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      });
      test('Given the following three RouteConfig, Generate output', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView1'
            ..pathName = 'pathNamaw1'
            ..className = 'ebraClass1',
          RouteConfig()
            ..name = 'loginView2'
            ..pathName = 'pathNamaw2'
            ..className = 'ebraClass2',
          RouteConfig()
            ..name = 'loginView3'
            ..pathName = 'pathNamaw3'
            ..className = 'ebraClass3'
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterWithThreeNamePathNameClassName,
        );
      });
      test('''
When routeType is material, 
(cupertinoNavTitle customRouteBarrierDismissible durationInMilliseconds initial reverseDurationInMilliseconds transitionBuilder)
 does not have any effect''', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..cupertinoNavTitle = 'cupertinooo'
            ..customRouteBarrierDismissible = true
            ..durationInMilliseconds = 22
            ..initial = true
            ..reverseDurationInMilliseconds = 2
        ];

        generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      });

      test('When fullscreenDialog is true', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..fullscreenDialog = true
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithNamePathNameClassNameFullScreenDialogIsTrue);
      });
      test('When fullscreenDialog is false', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..fullscreenDialog = false
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithFullScreenDialogIsFalse);
      });
      test('When adding one RouteGuardConfig', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..guards = [
              RouteGuardConfig(import: 'guard/import.dart', type: 'GuardType')
            ]
        ];

        generateRouteAndExpectResult(routes, kRouterWithOneGuard);
      });
      test('When adding two RouteGuardConfig', () {
        final routes = [
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
        ];

        generateRouteAndExpectResult(routes, kRouterWithTwoGuards);
      });
      test('When hasConstConstructor is false have no effect ', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..hasConstConstructor = false
        ];

        generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      });
      test('When hasConstConstructor is true', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..hasConstConstructor = true
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithHasConstConstructorIsTrue);
      });
      test('When hasWrapper is false have no effect ', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..hasWrapper = false
        ];

        generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      });
      test('When hasConstConstructor is true', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..hasWrapper = true
        ];

        generateRouteAndExpectResult(routes, kRouterWithHasWrapperIsTrue);
      });
      test('When has two imports', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..imports = ['import one', 'import two']
        ];
        generateRouteAndExpectResult(routes, kRouterWithImports);
      });
      test('When maintainstate is true', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..maintainState = true
        ];
        generateRouteAndExpectResult(routes, kRouterWithMaintainStateIsTrue);
      });
      test('When maintainstate is false', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..maintainState = false
        ];
        generateRouteAndExpectResult(routes, kRouterWithMaintainStateIsFalse);
      });
      test(
          'When adding an empty parameter, SHould throw InvalidGeneratorInputException ',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [RouteParamConfig()]
        ];
        generateRoutesAndExpectException<InvalidGeneratorInputException>(routes,
            ExceptionMessages.isPathParamAndIsQueryParamShouldNotBeNull);
      });
      test('When adding a parameter with PathParam: false, isQueryParam: false',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(isPathParam: false, isQueryParam: false)
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryFalse);
      });
      test('When adding a parameter with PathParam: true, isQueryParam: false',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(isPathParam: true, isQueryParam: false)
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathTrueQueryFalse);
      });
      test('When adding a parameter with PathParam: true, isQueryParam: true',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(isPathParam: true, isQueryParam: true)
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathTrueQueryFalse);
      });
      test('When adding a parameter with PathParam: false, isQueryParam: true',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(isPathParam: false, isQueryParam: true)
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrue);
      });
      test('When adding a parameter with PathParam: false, isQueryParam: true',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(isPathParam: false, isQueryParam: true)
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrue);
      });
      test(
          'When adding a parameter with PathParam: false, isQueryParam: true, alias: aliaso',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(
                  isPathParam: false, isQueryParam: true, alias: 'aliaso')
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrueAlias);
      });
      test(
          'When adding a parameter with PathParam: false, isQueryParam: true, defaultValueCode: 2',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(
                  isPathParam: false, isQueryParam: true, defaultValueCode: '2')
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrueDefaultCode2);
      });
      test(
          'When adding a parameter with PathParam: false, isQueryParam: true, imports',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(
                  isPathParam: false,
                  isQueryParam: true,
                  imports: {'parameter/import1', 'parameter/import2'})
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrueImports);
      });
      test(
          'When adding a parameter with PathParam: false, isQueryParam: true, isPositional: true',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(
                isPathParam: false,
                isQueryParam: true,
                isPositional: true,
              )
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrueIsPositionalTrue);
      });
      test(
          'When adding a parameter with PathParam: false, isQueryParam: true, isRequired: true',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(
                isPathParam: false,
                isQueryParam: true,
                isRequired: true,
              )
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrueIsRequiredTrue);
      });
      test(
          'When adding a parameter with PathParam: false, isQueryParam: true, isRequired: true,name: ebra',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(
                  isPathParam: false, isQueryParam: true, name: 'ebra')
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryTrueIsRequiredTrueName);
      });
      test(
          'When adding a parameter with PathParam: false, isQueryParam: false, type: newType',
          () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..parameters = [
              RouteParamConfig(
                  isPathParam: false, isQueryParam: false, type: 'newType')
            ]
        ];

        generateRouteAndExpectResult(
            routes, kRouterWithParameterPathFalseQueryFalseType);
      });
      test('When adding returnType = returnYpe', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..returnType = 'returnYpe'
        ];

        generateRouteAndExpectResult(routes, kRouterWithRetrunType);
      });
      test('When adding NestedRouter', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..returnType = 'returnYpe'
            ..routerConfig = RouterConfig(
                routesClassName: 'MyNestedRoutess',
                routeNamePrefix: 'prefexNestedRouter',
                routerClassName: 'MyNestedRouteerrr',
                globalRouteConfig: RouteConfig()
                  ..name = 'globalNestedView'
                  ..pathName = 'globalNestedPath'
                  ..className = 'globalNestedClass',
                routes: [
                  RouteConfig()
                    ..name = 'nestedView'
                    ..pathName = 'nestedPath'
                    ..className = 'nestedClass'
                ])
        ];

        generateRouteAndExpectResult(routes, kRouterWithNestedRouter);
      });
    });
    group('RouteType.cupertino -', () {
      test('Given the following RouteConfig, Generate output', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.cupertino
        ];

        generateRouteAndExpectResult(
            routes, kRouterTypeCupertinoWithNamePathNameClassName);
      });
      test('With cupertinoNavTitle', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.cupertino
            ..cupertinoNavTitle = 'cupertinoNavTitle'
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeCupertinoWithCupertinoNavTitle,
        );
      });
      test('With cupertinoNavTitle', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.cupertino
            ..cupertinoNavTitle = 'cupertinoNavTitle'
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeCupertinoWithCupertinoNavTitle,
        );
      });
    });
    group('RouteType.adaptive -', () {
      test('Given the following RouteConfig, Generate output', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.adaptive
        ];

        generateRouteAndExpectResult(routes, kRouterTypeAdaptive);
      });
      test('With cupertinoNavTitle', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.adaptive
            ..cupertinoNavTitle = 'cupertinooo'
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeAdaptiveWithCupertinoNavTitle,
        );
      });
    });
    group('RouteType.custom -', () {
      test('Given the following RouteConfig, Generate output', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.custom
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeCustom,
        );
      });
      test('With cupertinoNavTitle', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.custom
            ..cupertinoNavTitle = 'cupertinooo'
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeCustomWithTitleNavBar,
        );
      });
      test('With customRouteBarrierDismissible', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.custom
            ..customRouteBarrierDismissible = false
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeCustomWithbarrierDismissible,
        );
      });
      test('With durationInMilliseconds', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.custom
            ..durationInMilliseconds = 22
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeCustomWithTransitionDuration,
        );
      });
      test('With reverseDurationInMilliseconds', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView'
            ..pathName = 'pathNamaw'
            ..className = 'ebraClass'
            ..routeType = RouteType.custom
            ..reverseDurationInMilliseconds = 2
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterTypeCustomWithReverseDurationInMilliseconds,
        );
      });
    });
    group('Mixed -', () {
      test('Given random routing system', () {
        final routes = [
          RouteConfig()
            ..name = 'loginView1'
            ..pathName = 'pathNamaw1'
            ..className = 'ebraClass1'
            ..routeType = RouteType.custom
            ..reverseDurationInMilliseconds = 2
            ..durationInMilliseconds = 22
            ..cupertinoNavTitle = 'cupertinooo',
          RouteConfig()
            ..name = 'loginView2'
            ..pathName = 'pathNamaw2'
            ..className = 'ebraClass2'
            ..parameters = [
              RouteParamConfig(isPathParam: false, isQueryParam: true)
            ],
          RouteConfig()
            ..name = 'loginView3'
            ..pathName = 'pathNamaw3'
            ..className = 'ebraClass3'
            ..parameters = [
              RouteParamConfig(isPathParam: false, isQueryParam: false)
            ],
          RouteConfig()
            ..name = 'loginView4'
            ..pathName = 'pathNamaw4'
            ..className = 'ebraClass4'
            ..maintainState = false,
          RouteConfig()
            ..name = 'loginView5'
            ..pathName = 'pathNamaw5'
            ..className = 'ebraClass5'
            ..routeType = RouteType.adaptive
            ..cupertinoNavTitle = 'cupertinooo',
          RouteConfig()
            ..name = 'loginView6'
            ..pathName = 'pathNamaw6'
            ..className = 'ebraClass6'
            ..routeType = RouteType.cupertino
        ];

        generateRouteAndExpectResult(routes, kRouterMixin);
      });
    });
  });
}
