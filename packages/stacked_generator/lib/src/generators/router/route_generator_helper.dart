import 'package:stacked_generator/src/generators/router/route_config/route_config.dart';
import 'package:stacked_generator/utils.dart';

mixin RouteGeneratorHelper {
  String generateCommentBoxWithMessage(String message) => '''

/// ************************************************************************
/// $message
/// *************************************************************************

''';

  String generateRoutesConstantsMap(
      List<RouteConfig> routes, String routesClassName) {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.writeln('class $routesClassName {');
    var allNames = <String>{};
    routes.forEach((r) {
      final routeName = r.name;
      final path = r.pathName;

      if (path.contains(':')) {
        // handle template paths
        stringBuffer.writeln("static const String _$routeName = '$path';");
        allNames.add('_$routeName');
        var params = RegExp(r':([^/]+)').allMatches(path).map((m) {
          var match = m.group(1);
          if (match!.endsWith('?')) {
            return "dynamic  ${match.substring(0, match.length - 1)} = ''";
          } else {
            return "@required  dynamic $match";
          }
        });
        stringBuffer.writeln(
          "static String $routeName({${params.join(',')}}) => '${path.replaceAllMapped(RegExp(r'([:])|([?])'), (m) {
            if (m[1] != null) {
              return '\$';
            } else {
              return '';
            }
          })}';",
        );
      } else {
        allNames.add(routeName);
        stringBuffer.writeln("static const String $routeName = '$path';");
      }
    });
    stringBuffer.writeln("static const all = <String>{");
    allNames.forEach((name) => stringBuffer.write('$name,'));
    stringBuffer.write("};");
    stringBuffer.writeln('}');
    return stringBuffer.toString();
  }

  String generateRouterClass(
    List<RouteConfig> routes,
    String routerClassName,
    String routesClassName,
  ) {
    StringBuffer stringBuffer = StringBuffer();

    stringBuffer.writeln('\nclass $routerClassName extends RouterBase {');

    stringBuffer.writeln('''
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     ''');
    for (var route in routes) {
      stringBuffer.write(_generateRouteTemplates(route, routesClassName));
    }
    stringBuffer.writeln();
    stringBuffer.write('];');

    stringBuffer.writeln('''
       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        ''');
    stringBuffer.writeln();

    for (var route in routes) {
      stringBuffer.write(_generateRouteGeneratorFunction(route));
    }

    stringBuffer.write('};');

    stringBuffer.writeln('}');

    return stringBuffer.toString();
  }

  String _generateRouteTemplates(RouteConfig route, String routesClassName) {
    StringBuffer stringBuffer = StringBuffer();

    stringBuffer.writeln();

    stringBuffer.write("RouteDef(${routesClassName}.${route.templateName}");
    stringBuffer.writeln();
    stringBuffer.writeln(",page: ${route.className}");
    if (route.guards.isNotEmpty == true) {
      stringBuffer.writeln(
          ",guards:${route.guards.map((e) => e.type).toList().toString()}");
    }
    if (route.children.isNotEmpty) {
      stringBuffer.writeln(",generator: ${capitalize(route.name)}Router(),");
    }
    stringBuffer.write('),');

    return stringBuffer.toString();
  }

  String _generateRouteGeneratorFunction(RouteConfig route) {
    StringBuffer stringBuffer = StringBuffer();

    var routesMap = <String, RouteConfig>{};

    routesMap[route.className] = route;

    routesMap.forEach((name, route) {
      stringBuffer.writeln('$name: (data) {');

      stringBuffer.write(route.registerRoutes());

      stringBuffer.write("},");
    });
    return stringBuffer.toString();
  }
}
