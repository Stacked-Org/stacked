import 'package:stacked_generator/resolved_type.dart';
import 'package:stacked_generator/route_config_resolver.dart';
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
    void generateRouteAndExpectResult(
      List<RouteConfig> routes,
      dynamic expectedResult, {
      bool verbose = false,
    }) {
      final routerBaseGenerator = RouterGenerator(RouterConfig(
        routesClassName: 'RoutesTestClassName',
        routerClassName: 'RouterTestClassName',
        generateNavigationHelper: true,
        routes: routes,
      ));
      final result = routerBaseGenerator.generate();

      // ignore: avoid_print
      if (verbose) print(result);
      expect(result, expectedResult);
    }

    group('RouteType.material - default -', () {
      test('When routes are empty', () {
        List<RouteConfig> routes = [];

        generateRouteAndExpectResult(
          routes,
          '',
        );
      });

      test('Given the following RouteConfig, Generate output', () {
        final List<RouteConfig> routes = [
          const MaterialRouteConfig(
            name: 'loginView',
            pathName: 'pathNamaw',
            className: MapEntry('TestClass', 'test.dart'),
          )
        ];
        generateRouteAndExpectResult(
          routes,
          kRouterWithNamePathNameClassName,
        );
      });

      test('When adding NestedRouter with one child', () {
        final List<RouteConfig> routes = [
          const MaterialRouteConfig(
            name: 'loginView1',
            pathName: 'pathNamaw1',
            className: MapEntry('TestClass1', 'test1.dart'),
            returnType: 'returnYpe1',
            children: [
              MaterialRouteConfig(
                name: 'nestedView1',
                pathName: 'nestedPath1',
                className: MapEntry('nestedClass1', 'nested_test1.dart'),
                parentClassName: 'ParentClass',
              )
            ],
          )
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterWithNestedRouter,
        );
      });

      test('''
When a view parameter inside another data structure,
 Should assign the aliased import to the appropriate type''', () {
        final List<RouteConfig> routes = [
          CustomRouteConfig(
            name: 'loginView',
            pathName: 'pathNamaw',
            className: const MapEntry('TestClass', 'test.dart'),
            parameters: [
              RouteParamConfig(
                isPathParam: false,
                isQueryParam: false,
                name: 'markers',
                type: ResolvedType(name: 'List', typeArguments: [
                  ResolvedType(name: 'Marker', import: 'map.dart')
                ]),
              ),
            ],
          )
        ];

        generateRouteAndExpectResult(
          routes,
          kRouterWithAliasedImport,
        );
      });
      test('When a parameter type is String', () {
        final List<RouteConfig> routes = [
          CustomRouteConfig(
            name: 'loginView',
            pathName: 'pathNamaw',
            className: const MapEntry('TestClass', 'test.dart'),
            parameters: [
              RouteParamConfig(
                isPathParam: false,
                isQueryParam: false,
                name: 'name',
                type: ResolvedType(name: 'String', import: 'map.dart'),
              ),
            ],
          )
        ];

        generateRouteAndExpectResult(
          routes,
          kParameterTypeString,
        );
      });

      group('Mixed -', () {
        test('Given this routing system', () {
          final List<RouteConfig> routes = [
            const CustomRouteConfig(
              name: 'loginView1',
              pathName: 'pathNamaw1',
              className: MapEntry('TestClass1', 'test1.dart'),
              reverseDurationInMilliseconds: 2,
              durationInMilliseconds: 22,
            ),
            MaterialRouteConfig(
                name: 'loginView2',
                pathName: 'pathNamaw2',
                className: const MapEntry('TestClass2', 'test2.dart'),
                parameters: [
                  RouteParamConfig(
                    name: 'test2paramName',
                    type: ResolvedType(
                        name: 'Test2Type', import: 'test2type.dart'),
                    isPathParam: false,
                    isQueryParam: true,
                  ),
                ]),
            MaterialRouteConfig(
                name: 'loginView3',
                pathName: 'pathNamaw3',
                className: const MapEntry('TestClass3', 'test3.dart'),
                parameters: [
                  RouteParamConfig(
                    name: 'test3paramName',
                    type: ResolvedType(
                        name: 'Test3Type', import: 'test3type.dart'),
                    isPathParam: false,
                    isQueryParam: false,
                  ),
                ]),
            const MaterialRouteConfig(
                name: 'loginView4',
                pathName: 'pathNamaw4',
                className: MapEntry('TestClass4', 'test4.dart'),
                maintainState: false),
            const AdaptiveRouteConfig(
                name: 'loginView5',
                pathName: 'pathNamaw5',
                className: MapEntry('TestClass5', 'test5.dart'),
                cupertinoNavTitle: 'cupertinooo'),
            const CupertinoRouteConfig(
              name: 'loginView6',
              pathName: 'pathNamaw6',
              className: MapEntry('TestClass6', 'test6.dart'),
            ),
          ];

          generateRouteAndExpectResult(
            routes,
            kRouterMixin,
          );
        });
      });
    });
  });
}
