import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/router_class/router_class_builder_helper.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';

class RouterClassBuilder with RouterClassBuilderHelper {
  final List<RouteConfig> routes;
  final String routerClassName;
  final String routesClassName;
  const RouterClassBuilder({
    required this.routes,
    required this.routerClassName,
    required this.routesClassName,
  });

  Class buildRouterClass() {
    return Class((b) => b
      ..name = routerClassName
      ..extend = const Reference('RouterBase', 'package:stacked/stacked.dart')
      ..fields.addAll([
        listOfRoutes(routes, routesClassName),
        mapOfPages(routes),
      ])
      ..methods.addAll([
        routesGetter,
        pagesMapGetter,
      ]));
  }
}
