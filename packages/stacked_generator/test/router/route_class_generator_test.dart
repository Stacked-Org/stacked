import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/router/generator/router_generator.dart';
import 'package:stacked_generator/src/generators/router/route_config/adaptive_route_config.dart';
import 'package:stacked_generator/src/generators/router/route_config/cupertino_route_config.dart';
import 'package:stacked_generator/src/generators/router/route_config/custom_route_config.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:stacked_generator/src/generators/router/router_config/router_config.dart';
import 'package:test/test.dart';

import '../helpers/test_constants/router_constants.dart';

void main() {
  group('RouteClassGeneratorTest -', () {
    void generateRoutesAndExpectException<T>(List<RouteConfig> routes,
        [String? exceptionMessage]) {
      final routerBaseGenerator = RouterGenerator(RouterConfig(
          routesClassName: 'RoutesTestClassName',
          routerClassName: 'RouterTestClassName',
          routes: routes));
      expect(
        () => routerBaseGenerator.generate(),
        throwsA(predicate<dynamic>((e) => e is T && exceptionMessage == null
            ? true
            : e.message == exceptionMessage)),
      );
    }

    /// How to copy a test result(Snapshot):
    /// 1. Pass true to verbose argument
    /// 2. Run the test
    /// 3. Open the debug console in your IDE and copy the result
    ///
    /// Note: It usually adds an extra line in the bottom of the result
    void generateRouteAndExpectResult(
        List<RouteConfig> routes, dynamic expectedResult,
        {bool verbose = true}) {
      final routerBaseGenerator = RouterGenerator(RouterConfig(
          routesClassName: 'RoutesTestClassName',
          routerClassName: 'RouterTestClassName',
          generateNavigationHelper: true,
          routes: routes));
      final result = routerBaseGenerator.generate();
      if (verbose) print(result);
      expect(result, expectedResult);
    }

    group('RouteType.material - default -', () {
      test('When routes are empty', () {
        List<RouteConfig> routes = [];

        generateRouteAndExpectResult(
          routes,
          kRouterWithEmptyRoutes,
        );
      });

      test('Given the following RouteConfig, Generate output', () {
        final List<RouteConfig> routes = [
          MaterialRouteConfig(
            name: 'loginView',
            pathName: 'pathNamaw',
            className: MapEntry('TestClass', 'test.dart'),
          )
        ];

        generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      });
      //   test('Given the following three RouteConfig, Generate output', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //         name: 'loginView1',
      //         pathName: 'pathNamaw1',
      //         className: 'TestClass1',
      //       ),
      //       MaterialRouteConfig(
      //         name: 'loginView2',
      //         pathName: 'pathNamaw2',
      //         className: 'TestClass2',
      //       ),
      //       MaterialRouteConfig(
      //         name: 'loginView3',
      //         pathName: 'pathNamaw3',
      //         className: 'TestClass3',
      //       ),
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterWithThreeNamePathNameClassName,
      //     );
      //   });

      //   test('When fullscreenDialog is true', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //         fullscreenDialog: true,
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithNamePathNameClassNameFullScreenDialogIsTrue);
      //   });
      //   test(
      //       'When fullscreenDialog is false, Should add nothing cause it is default',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //         fullscreenDialog: false,
      //       )
      //     ];

      //     generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      //   });

      //   test('When hasConstConstructor is false have no effect ', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           hasConstConstructor: false)
      //     ];

      //     generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      //   });
      //   test('When hasConstConstructor is true', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           hasConstConstructor: true)
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithHasConstConstructorIsTrue);
      //   });
      //   test('When hasWrapper is false have no effect ', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           hasWrapper: false)
      //     ];

      //     generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      //   });
      //   test('When hasConstConstructor is true', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           hasWrapper: true)
      //     ];

      //     generateRouteAndExpectResult(routes, kRouterWithHasWrapperIsTrue);
      //   });
      //   test('When has two imports', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           imports: {'import one', 'import two'})
      //     ];
      //     generateRouteAndExpectResult(routes, kRouterWithImports);
      //   });
      //   test('When maintainstate is true, Should add nothing cause it is default',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           maintainState: true)
      //     ];
      //     generateRouteAndExpectResult(routes, kRouterWithNamePathNameClassName);
      //   });
      //   test('When maintainstate is false', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           maintainState: false)
      //     ];
      //     generateRouteAndExpectResult(routes, kRouterWithMaintainStateIsFalse);
      //   });
      //   test(
      //       'When adding an empty parameter, SHould throw InvalidGeneratorInputException ',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [RouteParamConfig()])
      //     ];
      //     generateRoutesAndExpectException<InvalidGeneratorInputException>(routes,
      //         ExceptionMessages.isPathParamAndIsQueryParamShouldNotBeNull);
      //   });
      //   test('When adding a parameter with PathParam: false, isQueryParam: false',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(isPathParam: false, isQueryParam: false)
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryFalse);
      //   });
      //   test('When adding a parameter with PathParam: true, isQueryParam: false',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(isPathParam: true, isQueryParam: false)
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathTrueQueryFalse);
      //   });
      //   test('When adding a parameter with PathParam: true, isQueryParam: true',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(isPathParam: true, isQueryParam: true)
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathTrueQueryFalse);
      //   });
      //   test('When adding a parameter with PathParam: false, isQueryParam: true',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(isPathParam: false, isQueryParam: true)
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryTrue);
      //   });
      //   test(
      //       'When adding a parameter with PathParam: false, isQueryParam: true, alias: aliaso',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(
      //                 isPathParam: false, isQueryParam: true, alias: 'aliaso')
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryTrueAlias);
      //   });
      //   test(
      //       'When adding a parameter with PathParam: false, isQueryParam: true, defaultValueCode: 2',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(
      //                 isPathParam: false,
      //                 isQueryParam: true,
      //                 defaultValueCode: '2')
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryTrueDefaultCode2);
      //   });
      //   test(
      //       'When adding a parameter with PathParam: false, isQueryParam: true, imports',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(
      //                 isPathParam: false,
      //                 isQueryParam: true,
      //                 imports: {'parameter/import1', 'parameter/import2'})
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryTrueImports);
      //   });
      //   test(
      //       'When adding a parameter with PathParam: false, isQueryParam: true, isPositional: true',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(
      //               isPathParam: false,
      //               isQueryParam: true,
      //               isPositional: true,
      //             )
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryTrueIsPositionalTrue);
      //   });
      //   test(
      //       'When adding a parameter with PathParam: false, isQueryParam: true, isRequired: true',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(
      //               isPathParam: false,
      //               isQueryParam: true,
      //               isRequired: true,
      //             )
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryTrueIsRequiredTrue);
      //   });
      //   test(
      //       'When adding a parameter with PathParam: false, isQueryParam: true, isRequired: true,name: ebra',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(
      //               isPathParam: false,
      //               isQueryParam: true,
      //               name: 'ebra',
      //             )
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryTrueIsRequiredTrueName);
      //   });
      //   test(
      //       'When adding a parameter with PathParam: false, isQueryParam: false, type: newType',
      //       () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           parameters: [
      //             RouteParamConfig(
      //               isPathParam: false,
      //               isQueryParam: false,
      //               type: 'newType',
      //             )
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithParameterPathFalseQueryFalseType);
      //   });
      //   test('When adding returnType = returnYpe', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           returnType: 'returnYpe')
      //     ];

      //     generateRouteAndExpectResult(routes, kRouterWithRetrunType);
      //   });
      //   test('When adding returnType = <CupertinoRoute>', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           returnType: '<CupertinoRoute>')
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterWithRetrunTypeCupertinoRoute);
      //   });
      test('When adding NestedRouter with one child', () {
        final List<RouteConfig> routes = [
          MaterialRouteConfig(
            name: 'loginView1',
            pathName: 'pathNamaw1',
            className: MapEntry('TestClass1', 'test1.dart'),
            returnType: 'returnYpe1',
            children: [
              MaterialRouteConfig(
                name: 'nestedView1',
                pathName: 'nestedPath1',
                className: MapEntry('nestedClass1', 'nested_test1.dart'),
                isChild: true,
              )
            ],
          )
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterWithNestedRouter,
        );
      });
      //   test('When adding multiple NestedRouter with one child each', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView1',
      //           pathName: 'pathNamaw1',
      //           className: 'TestClass1',
      //           returnType: 'returnYpe1',
      //           children: [
      //             MaterialRouteConfig(
      //                 name: 'nestedView1',
      //                 pathName: 'nestedPath1',
      //                 className: 'nestedClass1',
      //                 isChild: true,
      //                 children: [
      //                   MaterialRouteConfig(
      //                     name: 'multiNestedmultiNestedView1',
      //                     pathName: 'multiNestedmultiNestedPath1',
      //                     className: 'multiNestedmultiNestedClass1',
      //                     isChild: true,
      //                   )
      //                 ])
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterWithMultipleNestedRouter,
      //     );
      //   });
      //   test('When adding NestedRouter with three different childs', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView2',
      //           pathName: 'pathNamaw2',
      //           className: 'TestClass2',
      //           returnType: 'returnYpe2',
      //           children: [
      //             MaterialRouteConfig(
      //               name: 'firstView',
      //               pathName: 'firstPath',
      //               className: 'firstClass',
      //               isChild: true,
      //             ),
      //             CupertinoRouteConfig(
      //               name: 'secondView',
      //               pathName: 'secondPath',
      //               className: 'secondClass',
      //               isChild: true,
      //             ),
      //             CustomRouteConfig(
      //               name: 'thirdView',
      //               pathName: 'thirdPath',
      //               className: 'thirdClass',
      //               isChild: true,
      //             ),
      //           ])
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterWithThreeNestedRouter,
      //     );
      //   });
      //   test('When adding NestedRouter with six different childs', () {
      //     final List<RouteConfig> routes = [
      //       MaterialRouteConfig(
      //           name: 'loginView3',
      //           pathName: 'pathNamaw3',
      //           className: 'TestClass3',
      //           returnType: 'returnYpe3',
      //           children: [
      //             MaterialRouteConfig(
      //               name: 'firstView',
      //               pathName: 'firstPath',
      //               className: 'firstClass',
      //               isChild: true,
      //             ),
      //             CupertinoRouteConfig(
      //               name: 'secondView',
      //               pathName: 'secondPath',
      //               className: 'secondClass',
      //               isChild: true,
      //             ),
      //             AdaptiveRouteConfig(
      //               name: 'thirdView',
      //               pathName: 'thirdPath',
      //               className: 'thirdClass',
      //               isChild: true,
      //             ),
      //           ]),
      //       AdaptiveRouteConfig(
      //           name: 'loginView4',
      //           pathName: 'pathNamaw4',
      //           className: 'TestClass4',
      //           returnType: 'returnYpe4',
      //           children: [
      //             MaterialRouteConfig(
      //               name: 'fourthView',
      //               pathName: 'fourthPath',
      //               className: 'fourthClass',
      //               isChild: true,
      //             ),
      //             CupertinoRouteConfig(
      //               name: 'fifthView',
      //               pathName: 'fifthPath',
      //               className: 'fifthClass',
      //               isChild: true,
      //             ),
      //             CustomRouteConfig(
      //               name: 'sixthView',
      //               pathName: 'sixthPath',
      //               className: 'sixthClass',
      //               isChild: true,
      //             ),
      //           ]),
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterWithSixNestedRouter,
      //     );
      //   });
      // });
      // group('RouteType.cupertino -', () {
      //   test('Given the following RouteConfig, Generate output', () {
      //     final List<RouteConfig> routes = [
      //       CupertinoRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterTypeCupertinoWithNamePathNameClassName);
      //   });
      //   test('With cupertinoNavTitle', () {
      //     final List<RouteConfig> routes = [
      //       CupertinoRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           cupertinoNavTitle: 'cupertinoNavTitle')
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCupertinoWithCupertinoNavTitle,
      //     );
      //   });
      // });
      // group('RouteType.cupertino -', () {
      //   test('Given the following RouteConfig, Generate output', () {
      //     final List<RouteConfig> routes = [
      //       CupertinoRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //         routes, kRouterTypeCupertinoWithNamePathNameClassName);
      //   });
      //   test('With cupertinoNavTitle', () {
      //     final List<RouteConfig> routes = [
      //       CupertinoRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           cupertinoNavTitle: 'cupertinoNavTitle')
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCupertinoWithCupertinoNavTitle,
      //     );
      //   });
      //   test('With parameters path = false, query = false', () {
      //     final List<RouteConfig> routes = [
      //       CupertinoRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //         parameters: [
      //           RouteParamConfig(
      //             isPathParam: false,
      //             isQueryParam: false,
      //           ),
      //         ],
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCupertinoWithParametersPathFalseQueryFalse,
      //     );
      //   });
      // });
      // group('RouteType.adaptive -', () {
      //   test('Given the following RouteConfig, Generate output', () {
      //     final List<RouteConfig> routes = [
      //       AdaptiveRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //       )
      //     ];

      //     generateRouteAndExpectResult(routes, kRouterTypeAdaptive);
      //   });
      //   test('With cupertinoNavTitle', () {
      //     final List<RouteConfig> routes = [
      //       AdaptiveRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           cupertinoNavTitle: 'cupertinooo')
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeAdaptiveWithCupertinoNavTitle,
      //     );
      //   });
      //   test('With parameters path = false, query = false', () {
      //     final List<RouteConfig> routes = [
      //       AdaptiveRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //         parameters: [
      //           RouteParamConfig(
      //             isPathParam: false,
      //             isQueryParam: false,
      //           ),
      //         ],
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeAdaptiveWithParametersPathFalseQueryFalse,
      //     );
      //   });
      // });
      // group('RouteType.custom -', () {
      //   test('Given the following RouteConfig, Generate output', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustom,
      //     );
      //   });

      //   test('With customRouteBarrierDismissible', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           customRouteBarrierDismissible: false)
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustomWithbarrierDismissible,
      //     );
      //   });
      //   test('With durationInMilliseconds', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           durationInMilliseconds: 22)
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustomWithTransitionDuration,
      //     );
      //   });
      //   test('With reverseDurationInMilliseconds', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           reverseDurationInMilliseconds: 2)
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustomWithReverseDurationInMilliseconds,
      //     );
      //   });
      //   test(
      //       'With customRouteOpaque true, Should add nothing cause it is default',
      //       () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           customRouteOpaque: true)
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustom,
      //     );
      //   });
      //   test('With customRouteOpaque false', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //           name: 'loginView',
      //           pathName: 'pathNamaw',
      //           className: 'TestClass',
      //           customRouteOpaque: false)
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustomWithCustomRouteOpaqueFalse,
      //     );
      //   });
      //   test('With parameters path = false, query = false', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //         parameters: [
      //           RouteParamConfig(
      //             isPathParam: false,
      //             isQueryParam: false,
      //           ),
      //         ],
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustomWithParametersPathFalseQueryFalse,
      //     );
      //   });
      //   test('With parameters path = false, query = true', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //         name: 'loginView',
      //         pathName: 'pathNamaw',
      //         className: 'TestClass',
      //         parameters: [
      //           RouteParamConfig(
      //             isPathParam: false,
      //             isQueryParam: true,
      //           ),
      //         ],
      //       )
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterTypeCustomWithParametersPathFalseQueryTrue,
      //     );
      //   });
      // });
      // group('Mixed -', () {
      //   test('Given random routing system', () {
      //     final List<RouteConfig> routes = [
      //       CustomRouteConfig(
      //         name: 'loginView1',
      //         pathName: 'pathNamaw1',
      //         className: 'TestClass1',
      //         reverseDurationInMilliseconds: 2,
      //         durationInMilliseconds: 22,
      //       ),
      //       MaterialRouteConfig(
      //           name: 'loginView2',
      //           pathName: 'pathNamaw2',
      //           className: 'TestClass2',
      //           parameters: [
      //             RouteParamConfig(
      //               isPathParam: false,
      //               isQueryParam: true,
      //             ),
      //           ]),
      //       MaterialRouteConfig(
      //           name: 'loginView3',
      //           pathName: 'pathNamaw3',
      //           className: 'TestClass3',
      //           parameters: [
      //             RouteParamConfig(
      //               isPathParam: false,
      //               isQueryParam: false,
      //             ),
      //           ]),
      //       MaterialRouteConfig(
      //           name: 'loginView4',
      //           pathName: 'pathNamaw4',
      //           className: 'TestClass4',
      //           maintainState: false),
      //       AdaptiveRouteConfig(
      //           name: 'loginView5',
      //           pathName: 'pathNamaw5',
      //           className: 'TestClass5',
      //           cupertinoNavTitle: 'cupertinooo'),
      //       CupertinoRouteConfig(
      //         name: 'loginView6',
      //         pathName: 'pathNamaw6',
      //         className: 'TestClass6',
      //       ),
      //     ];

      //     generateRouteAndExpectResult(
      //       routes,
      //       kRouterMixin,
      //     );
      //   });
    });
  });
}
