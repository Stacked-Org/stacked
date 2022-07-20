import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/generator/routes_class/routes_class_builder.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:test/test.dart';

import '../helpers/class_extension.dart';
import '../helpers/test_constants/router_constants.dart';

final List<RouteConfig> _routes = [
  MaterialRouteConfig(
    name: 'loginView',
    pathName: 'pathNamaw',
    className: MapEntry('LoginClass', 'ui/login_class.dart'),
  ),
  MaterialRouteConfig(
    name: 'homeView',
    pathName: '/family/:fid',
    className: MapEntry('HomeClass', 'ui/home_class.dart'),
  )
];

void main() {
  group('RoutesClassBuilderTest -', () {
    Class getBuilderInstance() => RoutesClassBuilder(
          routes: _routes,
        ).buildRoutesClass();

    group('addRoutesClassName -', () {
      test('Should generate routes class', () {
        final builder = getBuilderInstance();

        expect(
          builder.buildLibraryForClass,
          kRoutesClass,
        );
      });
    });
  });
}
