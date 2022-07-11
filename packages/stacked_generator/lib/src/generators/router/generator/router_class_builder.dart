import 'package:code_builder/code_builder.dart';

import '../../../../route_config_resolver.dart';

class RouterClassBuilder {
  final List<RouteConfig> routes;
  final String routerClassName;
  const RouterClassBuilder(
      {required this.routes, required this.routerClassName});

  /// Example
  ///
  /// class routerClassName extends RouterBase {
  /// @override
  /// List<RouteDef> get routes => _routes;
  /// final _routes = <RouteDef>[
  ///
  ///
  /// RouteDef(RoutesClassName.loginView
  /// ,page: LoginClass
  /// ),
  /// RouteDef(RoutesClassName._homeView
  /// ,page: HomeClass
  /// ),
  /// ];       @override
  ///        Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  ///         final _pagesMap = <Type, StackedRouteFactory>{
  ///
  ///
  /// LoginClass: (data) {
  /// var args = data.getArgs<LoginClassArguments>(
  /// orElse: ()=> LoginClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   LoginClass(loginArg:args.loginArg), settings: data,);
  /// },HomeClass: (data) {
  /// var args = data.getArgs<HomeClassArguments>(
  /// orElse: ()=> HomeClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   HomeClass(homeArg:args.homeArg), settings: data,);
  /// },};}
  Class BuildRouterClass() {
    final routesDef = routes.map((route) =>
        Reference('RouteDef', 'package:stacked/stacked.dart').newInstance(
          [Reference('Routes').property(route.name)],
          {
            'page': Reference(route.className.key, route.className.value),
          },
        ));

    final routesField = Field((b) => b
      ..name = '_routes'
      ..modifier = FieldModifier.final$
      ..assignment = literalList(
              routesDef, Reference('RouteDef', 'package:stacked/stacked.dart'))
          .code);

    final routesGetterField = Method((b) => b
      ..name = 'routes'
      ..annotations.add(Reference('override'))
      ..type = MethodType.getter
      ..returns = TypeReference((b) => b
        ..symbol = 'List'
        ..types.add(TypeReference((b) => b
          ..symbol = 'RouteDef'
          ..url = 'package:stacked/stacked.dart'
          ..isNullable = true)))
      ..body = Reference('_routes').code);

    return Class((b) => b
      ..name = routerClassName
      ..extend = Reference('RouterBase', 'package:stacked/stacked.dart')
      ..fields.add(routesField)
      ..methods.add(routesGetterField));

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
