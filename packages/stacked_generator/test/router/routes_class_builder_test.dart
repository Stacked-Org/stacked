import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/generator/routes_class_builder.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:test/test.dart';

import '../helpers/common.dart';
import '../helpers/test_constants/router_constants.dart';

final List<RouteConfig> _routes = [
  MaterialRouteConfig(
    name: 'loginView',
    pathName: 'pathNamaw',
    className: 'LoginClass',
  ),
  MaterialRouteConfig(
    name: 'homeView',
    pathName: '/family/:fid',
    className: 'HomeClass',
  )
];

void main() {
  group('RouteClassBuilderTest -', () {
    Class getBuilderInstance() => RoutesClassBuilder(
          routes: _routes,
        ).buildRoutesClass();

    group('addRoutesClassName -', () {
      test('Should generate route class names', () {
        final builder = getBuilderInstance();

        expect(
          buildLibraryForClass(builder),
          routeClassNames,
        );
      });
    });
  });
}
