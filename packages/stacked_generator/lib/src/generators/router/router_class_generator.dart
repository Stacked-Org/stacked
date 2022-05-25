import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/router/route_generator_helper.dart';

import 'router_config.dart';

class RouterClassGenerator extends BaseGenerator with RouteGeneratorHelper {
  final RouterConfig _rootRouterConfig;

  RouterClassGenerator(this._rootRouterConfig);
  @override
  String generate() {
    writeLine("// ignore_for_file: public_member_api_docs");
    generateImports(_rootRouterConfig.routes);

    generateRoutesConstantsMap(
      _rootRouterConfig.routes,
      _rootRouterConfig.routesClassName,
    );

    generateRouterClass(
      _rootRouterConfig.routes,
      _rootRouterConfig.routerClassName,
      _rootRouterConfig.routesClassName,
    );

    if (_rootRouterConfig.generateNavigationHelper) {
      generateNavigationHelpers(_rootRouterConfig.routes,
          _rootRouterConfig.routerClassName, _rootRouterConfig.routesClassName);
    }

    generateArgumentHolders(_rootRouterConfig.routes);

    return stringBuffer.toString();
  }
}
