import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/arguments_class/arguments_class_builder.dart';
import 'package:stacked_generator/src/generators/router/route_config/material_route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/importable_type.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_parameter_config.dart';
import 'package:test/test.dart';

import '../../helpers/class_extension.dart';
import '../../helpers/test_constants/router_constants.dart';

final List<RouteConfig> _routes = [
  MaterialRouteConfig(
      name: 'loginView',
      pathName: 'pathNamaw',
      className: 'LoginClass',
      classImport: 'ui/login_class.dart',
      parameters: [
        ParamConfig(
          isPathParam: false,
          isQueryParam: false,
          isPositional: true,
          name: 'position',
          type: ResolvedType(name: 'Marker', import: 'marker.dart'),
        ),
        ParamConfig(
          isPathParam: false,
          isQueryParam: false,
          name: 'age',
          type: ResolvedType(name: 'int'),
        )
      ]),
  MaterialRouteConfig(
      name: 'homeView',
      pathName: '/family/:fid',
      className: 'HomeClass',
      classImport: 'ui/home_class.dart',
      parameters: [
        ParamConfig(
          isPathParam: false,
          isQueryParam: false,
          isPositional: true,
          name: 'car',
          type: ResolvedType(name: 'Car', import: 'car.dart'),
        ),
        ParamConfig(
          isPathParam: false,
          isQueryParam: false,
          name: 'age',
          type: ResolvedType(name: 'int'),
        )
      ])
];

void main() {
  group('ArgumentClassBuilderHelperTest -', () {
    Iterable<Class> getBuilderInstance() => ArgumentsClassBuilder(
          routes: _routes,
        ).buildViewsArguments(DartEmitter());

    group('addRoutesClassName -', () {
      test('Should generate routes class', () {
        final builder = getBuilderInstance();

        expect(
          builder.buildLibraryForClass,
          kRouteClassArguments,
        );
      });
    });
  });
}
