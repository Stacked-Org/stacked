import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/utils.dart';

import '../route_config/route_config.dart';
import '../router_config/router_config.dart';
import 'route_generator_helper.dart';

class RouterClassGenerator extends BaseGenerator with RouteGeneratorHelper {
  final RouterConfig _rootRouterConfig;

  RouterClassGenerator(this._rootRouterConfig);
  @override
  String generate() {
    writeLine("// ignore_for_file: public_member_api_docs");
    generateImports(
        [..._rootRouterConfig.routes, ..._rootRouterConfig.subRouters]);
    generateRouterByRouter(
        _rootRouterConfig.routes,
        _rootRouterConfig.routerClassName,
        _rootRouterConfig.routesClassName,
        _rootRouterConfig.generateNavigationHelper);
    return stringBuffer.toString();
  }

  void generateRouterByRouter(
    List<RouteConfig> routes,
    String routerClassName,
    String routesClassName,
    bool generateNavigationHelper,
  ) {
    generateRoutesConstantsMap(
      routes,
      routesClassName,
    );

    generateRouterClass(
      routes,
      routerClassName,
      routesClassName,
    );

    if (_rootRouterConfig.generateNavigationHelper) {
      generateNavigationHelpers(
        routes,
        routerClassName,
        routesClassName,
      );
    }

    generateArgumentHolders(routes);

    routes.where((element) => element.children.isNotEmpty).forEach((element) {
      generateRouterByRouter(
        element.children,
        capitalize(element.name + 'Router'),
        capitalize(element.name + 'Routes'),
        generateNavigationHelper,
      );
    });
  }
}
