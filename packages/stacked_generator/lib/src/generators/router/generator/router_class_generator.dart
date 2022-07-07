import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/router/generator/route_generator_builder.dart';
import 'package:stacked_generator/utils.dart';

import '../route_config/route_config.dart';
import '../router_config/router_config.dart';
import 'route_generator_helper.dart';

class RouterClassGenerator extends RouteGeneratorHelper
    implements BaseGenerator {
  final RouterConfig _rootRouterConfig;

  RouterClassGenerator(this._rootRouterConfig);
  @override
  String generate() {
    final routeGeneratorBuilder = RouteGeneratorBuilder(
      routes: _rootRouterConfig.routes,
      routesClassName: _rootRouterConfig.routesClassName,
    ).addHeaderComment().sortAndAddImports().addRoutesClassName();

    generateAllRoutersIncludingNestedOnes(
        _rootRouterConfig.routes,
        _rootRouterConfig.routerClassName,
        _rootRouterConfig.routesClassName,
        _rootRouterConfig.generateNavigationHelper);

    generateExtensionForStronglyTypedNavigation(_rootRouterConfig.routes);

    return routeGeneratorBuilder.serializeStringBuffer + serializeStringBuffer;
  }

  void generateAllRoutersIncludingNestedOnes(
    List<RouteConfig> routes,
    String routerClassName,
    String routesClassName,
    bool generateNavigationHelper,
  ) {
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
      generateAllRoutersIncludingNestedOnes(
        element.children,
        capitalize(element.name + 'Router'),
        capitalize(element.name + 'Routes'),
        generateNavigationHelper,
      );
    });
  }
}
