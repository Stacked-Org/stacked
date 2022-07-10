import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/generator/route_generator_builder.dart';
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
          pathName: '/family/:fid',
          className: 'HomeClass',
          imports: {
            '../ui/bottom_nav/profile/profile_view.dart',
            '../ui/details/details_view.dart',
            '../ui/form/example_form_view.dart',
            '../ui/home/home_view.dart',
          },
          parameters: [
            RouteParamConfig(
                imports: {'package:ClashTypeTwo/ClashType.dart'},
                name: 'homeArg',
                type: 'ClashType',
                isPathParam: false,
                isQueryParam: false)
          ])
    ];
    RouteGeneratorBuilder getBuilderInstance() => RouteGeneratorBuilder(
          routes: routes,
          routesClassName: 'RoutesClassName',
          routerClassName: 'routerClassName',
        );
    group('sortAndAddImports -', () {
      test('Should add and sort imports', () {
        final routeGeneratorHelper = getBuilderInstance().sortAndAddImports();
        expect(
          routeGeneratorHelper.serializeStringBuffer,
          kImportsWithoutAliasesTest,
        );
      });
    });
    group('addRoutesClassName -', () {
      test('Should generate route class names', () {
        final routeGeneratorHelper = getBuilderInstance().addRoutesClassName();
        expect(routeGeneratorHelper.serializeStringBuffer, routeClassNames);
      });
    });
    group('addRouterClass -', () {
      test('Should generate router class', () {
        final routeGeneratorHelper = getBuilderInstance().addRouterClass();
        expect(routeGeneratorHelper.serializeStringBuffer, kRouterClass);
      });
    });
    group('CodeBuilder -', () {
      test('build', () {
        final routeGeneratorHelper = getBuilderInstance().addRoutesClassName();
      });
    });
  });
}
