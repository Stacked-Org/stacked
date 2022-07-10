import 'package:stacked_generator/src/generators/base_generator.dart';

import '../../../../route_config_resolver.dart';
import '../../../../utils.dart';

class RouterClassBuilder with StringBufferUtils {
  final List<RouteConfig> routes;
  final String routesClassName;
  final String routerClassName;
  RouterClassBuilder({
    required this.routes,
    required this.routesClassName,
    required this.routerClassName,
  });

  /// Example result
  ///
  /// class routerClassName extends RouterBase {
  ///      @override
  ///      List<RouteDef> get routes => _routes;
  ///      final _routes = <RouteDef>[
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
  void addRouterClass() {
    writeLine('\nclass $routerClassName extends RouterBase {');

    writeLine('''
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     ''');
    for (var route in routes) {
      _addRouteTemplates(route, routesClassName);
    }
    newLine();
    write('];');

    write(
      '''
       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        ''',
      postlines: 2,
    );

    for (var route in routes) {
      _addRouteGeneratorFunction(route);
    }

    write('};');

    writeLine('}');
  }

  /// RouteDef(RoutesClassName._homeView
  /// ,page: HomeClass
  /// ),
  void _addRouteTemplates(RouteConfig route, String routesClassName) {
    write(
      "RouteDef(${routesClassName}.${route.templateName}",
      preLines: 1,
      postlines: 1,
    );
    writeLine(",page: ${route.className}");

    if (route.children.isNotEmpty) {
      writeLine(",generator: ${capitalize(route.name)}Router(),");
    }
    write('),');
  }

  /// HomeClass: (data) {
  /// var args = data.getArgs<HomeClassArguments>(
  /// orElse: ()=> HomeClassArguments(),);return MaterialPageRoute<dynamic>(builder: (context) =>   HomeClass(homeArg:args.homeArg), settings: data,);
  /// },
  void _addRouteGeneratorFunction(RouteConfig route) {
    writeLine('${route.className}: (data) {');

    write(route.registerRoutes());

    write("},");
  }
}
