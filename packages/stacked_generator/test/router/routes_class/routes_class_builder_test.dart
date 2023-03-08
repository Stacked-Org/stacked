import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/routes_class/routes_class_builder.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:test/test.dart';

import '../../helpers/class_extension.dart';
import '../../helpers/test_constants/router_constants.dart';

final List<RouteConfig> _routes = [
  const MaterialRouteConfig(
    name: 'loginView',
    pathName: 'pathNamaw',
    className: 'LoginClass',
    classImport: 'ui/login_class.dart',
  ),
  const MaterialRouteConfig(
    name: 'homeView',
    pathName: '/family/:fid',
    className: 'HomeClass',
    classImport: 'ui/home_class.dart',
  )
];

void main() {
  group('RoutesClassBuilderTest -', () {
    Class getBuilderInstance() => RoutesClassBuilder(
          routesClassName: 'RoutesClassName',
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
