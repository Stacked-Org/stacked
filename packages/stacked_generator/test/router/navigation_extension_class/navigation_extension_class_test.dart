import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/resolved_type.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/generator/navigate_extension_class/navigate_extension_class_builder.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:test/test.dart';

import '../../helpers/class_extension.dart';
import '../../helpers/test_constants/router_constants.dart';

final List<RouteConfig> _routes = [
  MaterialRouteConfig(
      name: 'loginView',
      pathName: 'pathNamaw',
      className: const MapEntry('LoginClass', 'ui/login_class.dart'),
      parameters: [
        RouteParamConfig(
          isPathParam: false,
          isQueryParam: false,
          isPositional: true,
          name: 'position',
          type: ResolvedType(name: 'Marker', import: 'marker.dart'),
        ),
        RouteParamConfig(
          isPathParam: false,
          isQueryParam: false,
          name: 'age',
          type: ResolvedType(name: 'int'),
        )
      ]),
  MaterialRouteConfig(
      name: 'homeView',
      pathName: '/family/:fid',
      className: const MapEntry('HomeClass', 'ui/home_class.dart'),
      parameters: [
        RouteParamConfig(
          isPathParam: false,
          isQueryParam: false,
          isPositional: true,
          name: 'car',
          type: ResolvedType(name: 'Car', import: 'car.dart'),
          defaultValueCode: "'TOYOTA'",
        ),
        RouteParamConfig(
          isPathParam: false,
          isQueryParam: false,
          name: 'age',
          type: ResolvedType(name: 'int'),
        ),
        RouteParamConfig(
          isPathParam: false,
          isQueryParam: false,
          name: 'markers',
          type: ResolvedType(name: 'List', typeArguments: [
            ResolvedType(
              name: 'Marker',
              import: 'map.dart',
            )
          ]),
        ),
      ])
];

void main() {
  group('NavigateExtensionClassBuilderTest -', () {
    Extension getBuilderInstance() => NavigateExtensionClassBuilder(
          routes: _routes,
        ).build();

    group('build -', () {
      test('Generate extension for strong type navigation', () {
        final builder = getBuilderInstance();

        expect(
          builder.buildLibraryForClass,
          kRouteNavigationExtension,
        );
      });
    });
  });
}
