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
      ..fields.add(listOfRoutes(routes))
      ..methods.addAll([
        routesGetter,
        pagesMapGetter,
      ]));

    // write(
    //   '''
    //    @override
    //    Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
    //     final _pagesMap = <Type, StackedRouteFactory>{
    //     ''',
    //   postlines: 2,
    // );

    // for (var route in routes) {
    //   _addRouteGeneratorFunction(route);
    // }

    // write('};');

    // writeLine('}');
  }

  /// RouteDef(RoutesClassName._homeView
  /// ,page: HomeClass
  /// ),
  // void _addRouteTemplates(RouteConfig route) {
  //   write(
  //     "RouteDef(${routesClassName}.${route.templateName}",
  //     preLines: 1,
  //     postlines: 1,
  //   );
  //   writeLine(",page: ${route.className}");

  //   if (route.children.isNotEmpty) {
  //     writeLine(",generator: ${capitalize(route.name)}Router(),");
  //   }
  //   write('),');
  // }

  /// HomeClass: (data) {
  /// var args = data.getArgs<HomeClassArguments>(
  /// orElse: ()=> HomeClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   HomeClass(homeArg:args.homeArg), settings: data,);
  /// },
  // void _addRouteGeneratorFunction(RouteConfig route) {
  //   writeLine('${route.className}: (data) {');

  //   write(route.registerRoutes());

  //   write("},");
  // }
}
