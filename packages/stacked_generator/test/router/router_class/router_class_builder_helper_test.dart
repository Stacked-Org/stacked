import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/generator/router_class/router_class_builder_helper.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:test/test.dart';

import '../../helpers/class_extension.dart';
import '../../helpers/test_constants/router_constants.dart';

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
  group('RouterClassBuilderHelperTest -', () {
    group('listOfRoutes -', () {
      test('list of routes that will assigned to the routes field', () {
        final helper = RouterClassBuilderHelper();
        expect(
            helper.listOfRoutes(_routes).buildLibraryForClass, kListOfRoutes);
      });
    });
    group('routesGetter -', () {
      test('generate the routesGetter field', () {
        final helper = RouterClassBuilderHelper();
        expect(helper.routesGetter.buildLibraryForClass, kRoutesGetter);
      });
    });
    group('pagesMapGetter -', () {
      test('generate the pagesMapGetter field', () {
        final helper = RouterClassBuilderHelper();
        expect(helper.pagesMapGetter.buildLibraryForClass, kPagesMapGetter);
      });
    });
  });
}
