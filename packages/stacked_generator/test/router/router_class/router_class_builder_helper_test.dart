import 'package:stacked_generator/src/generators/router/generator/router_class/router_class_builder_helper.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/importable_type.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_parameter_config.dart';
import 'package:test/test.dart';

import '../../helpers/class_extension.dart';
import '../../helpers/test_constants/router_constants.dart';

final List<RouteConfig> _routes = [
  // ignore: prefer_const_constructors
  MaterialRouteConfig(
    name: 'loginView',
    pathName: 'pathNamaw',
    className: 'LoginClass',
    classImport: 'ui/login_class.dart',
  ),
  MaterialRouteConfig(
    name: 'homeView',
    pathName: '/family/:fid',
    parameters: [
      ParamConfig(
          name: 'name',
          type: ResolvedType(name: 'String'),
          isRequired: true,
          isPathParam: false,
          isQueryParam: false)
    ],
    className: 'HomeClass',
    classImport: 'ui/home_class.dart',
  )
];
void main() {
  group('RouterClassBuilderHelperTest -', () {
    late RouterClassBuilderHelper routerClassBuilderHelper;

    setUp(() => routerClassBuilderHelper = RouterClassBuilderHelper());
    group('listOfRoutes -', () {
      test('list of routes that will assigned to the routes field', () {
        expect(
            routerClassBuilderHelper
                .listOfRoutes(_routes, 'RoutesClassName')
                .buildLibraryForClass,
            kListOfRoutes);
      });
    });
    group('routesGetter -', () {
      test('generate the routesGetter field', () {
        expect(routerClassBuilderHelper.routesGetter.buildLibraryForClass,
            kRoutesGetter);
      });
    });
    group('pagesMapGetter -', () {
      test('generate the pagesMapGetter field', () {
        expect(routerClassBuilderHelper.pagesMapGetter.buildLibraryForClass,
            kPagesMapGetter);
      });
    });
    group('mapOfPages -', () {
      test('generate the mapOfPages field for empty routes', () {
        expect(routerClassBuilderHelper.mapOfPages([]).buildLibraryForClass,
            kMapOfPagesForEmptyRoutes);
      });
      test('generate the mapOfPages field for 2 routes', () {
        expect(
            routerClassBuilderHelper.mapOfPages(_routes).buildLibraryForClass,
            kMapOfPages);
      });
    });
  });
}
