import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/router_class/router_class_builder_helper.dart';

import '../../../../../route_config_resolver.dart';

class RouterClassBuilder with RouterClassBuilderHelper {
  final List<RouteConfig> routes;
  final String routerClassName;
  const RouterClassBuilder({
    required this.routes,
    required this.routerClassName,
  });

  Class BuildRouterClass() {
    return Class((b) => b
      ..name = routerClassName
      ..extend = Reference('RouterBase', 'package:stacked/stacked.dart')
      ..fields.addAll([
        listOfRoutes(routes),
        mapOfPages(routes),
      ])
      ..methods.addAll([
        routesGetter,
        pagesMapGetter,
      ]));
  }
}
