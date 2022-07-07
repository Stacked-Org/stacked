import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/generator/route_generator_helper.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:test/test.dart';

import '../helpers/test_constants/router_constants.dart';

void main() {
  group('RouteGeneratorHelperTest -', () {
    final List<RouteConfig> routes = [
      MaterialRouteConfig(
          name: 'loginView',
          pathName: 'pathNamaw',
          className: 'LoginClass',
          imports: {
            'package:importone.dart',
            'package:importtwo.dart'
          },
          parameters: [
            RouteParamConfig(
                imports: {'package:ClashTypeOne/ClashType.dart'},
                name: 'loginArg',
                type: 'ClashType',
                isPathParam: false,
                isQueryParam: false)
          ]),
      MaterialRouteConfig(
          name: 'homeView',
          pathName: 'pathNamaw',
          className: 'HomeClass',
          parameters: [
            RouteParamConfig(
                imports: {'package:ClashTypeTwo/ClashType.dart'},
                name: 'homeArg',
                type: 'ClashType',
                isPathParam: false,
                isQueryParam: false)
          ])
    ];

    group('generateRoutesConstantsMap -', () {
      test('Should generate route constant map', () {
        final routeGeneratorHelper = RouteGeneratorHelper()
          ..generateRoutesConstantsMap(routes, 'RoutesClassName');
        expect(routeGeneratorHelper.serializeStringBuffer, kConstantsMap);
      });
    });
    group('generateRoutesConstantsMap -', () {
      test('Should generate route constant map', () {
        final routeGeneratorHelper = RouteGeneratorHelper()
          ..generateRouterClass(
            routes,
            'RouterClassName',
            'RoutesClassName',
          );
        expect(routeGeneratorHelper.serializeStringBuffer, kRouterClass);
      });
    });
  });
}
