import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/router/route_config/route_config.dart';
import 'package:stacked_generator/utils.dart';

class RouteGeneratorHelper with StringBufferUtils {
  void generateRouterClass(
    List<RouteConfig> routes,
    String routerClassName,
    String routesClassName,
  ) {
    writeLine('\nclass $routerClassName extends RouterBase {');

    writeLine('''
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     ''');
    for (var route in routes) {
      _generateRouteTemplates(route, routesClassName);
    }
    writeLine();
    write('];');

    writeLine('''
       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        ''');
    writeLine();

    for (var route in routes) {
      _generateRouteGeneratorFunction(route);
    }

    write('};');

    writeLine('}');
  }

  void _generateRouteTemplates(RouteConfig route, String routesClassName) {
    writeLine();

    write("RouteDef(${routesClassName}.${route.templateName}");
    writeLine();
    writeLine(",page: ${route.className}");

    if (route.children.isNotEmpty) {
      writeLine(",generator: ${capitalize(route.name)}Router(),");
    }
    write('),');
  }

  void _generateRouteGeneratorFunction(RouteConfig route) {
    var routesMap = <String, RouteConfig>{};

    routesMap[route.className] = route;

    routesMap.forEach((name, route) {
      writeLine('$name: (data) {');

      write(route.registerRoutes());

      write("},");
    });
  }

  void _generateHelperMethod(RouteConfig route, String routesClassName) {
    final genericType = route.returnType == null ? '' : '<${route.returnType}>';
    write('Future$genericType push${capitalize(route.name)}(');
    // generate constructor
    if (route.parameters.isNotEmpty) {
      write('{');
      route.parameters.forEach((param) {
        if (param.isRequired || param.isPositional) {
          write('@required ');
        }

        write('${param.type} ${param.name}');
        if (param.defaultValueCode != null) {
          write(' = ${param.defaultValueCode}');
        }
        write(',');
      });

      write('}');
    }
    writeLine(')');
    write(' => push$genericType($routesClassName.${route.name}');
    if (route.parameters.isNotEmpty) {
      write(',arguments: ');
      write('${route.argumentsHolderClassName}(');
      write(route.parameters.map((p) => '${p.name}: ${p.name}').join(','));
      write('),');
    }
    writeLine(');\n');
  }

  void generateNavigationHelpers(
    List<RouteConfig> routes,
    String routerClassName,
    String routesClassName,
  ) {
    write(
        _generateCommentBoxWithMessage('Navigation helper methods extension'));
    writeLine(
        'extension ${routerClassName}ExtendedNavigatorStateX on ExtendedNavigatorState {');
    for (var route in routes) {
      // skip routes that has path params until
      // until there's a practical way to handle them
      if (RegExp(r':([^/]+)').hasMatch(route.pathName)) {
        continue;
      }
      _generateHelperMethod(route, routesClassName);
    }
    writeLine('}');
  }

  void _generateArgsHolder(RouteConfig routeConfig) {
    writeLine('/// ${routeConfig.className} arguments holder class');
    final argsClassName = '${routeConfig.argumentsHolderClassName}';

    // generate fields
    final className =
        routeConfig.isChild ? 'Nested$argsClassName' : '$argsClassName';
    writeLine('class $className{');
    final params = routeConfig.notQueryAndNotPath;
    params.forEach((param) {
      writeLine('final ${param.type} ${param.name};');
    });

    // generate constructor
    writeLine('$className({');
    params.asMap().forEach((i, param) {
      if (param.isRequired || param.isPositional) {
        write('required ');
      }

      write('this.${param.name}');
      if (param.defaultValueCode != null) {
        write(' = ${param.defaultValueCode}');
      }
      if (i != params.length - 1) {
        write(',');
      }
    });
    writeLine('});');
    writeLine('}');
  }

  void generateArgumentHolders(List<RouteConfig> routes) {
    final routesWithArgsHolders = Map<String, RouteConfig>();

    // make sure we only generated holder classes for
    // routes with parameters
    // also prevent duplicate class with the same name from being generated;

    routes
        .where((r) => r.notQueryAndNotPath.isNotEmpty)
        .forEach((r) => routesWithArgsHolders[r.className] = r);

    if (routesWithArgsHolders.isNotEmpty) {
      write(_generateCommentBoxWithMessage('Arguments holder classes'));
      routesWithArgsHolders.values
          .forEach(((element) => _generateArgsHolder(element)));
    }
  }

  void generateExtensionForStronglyTypedNavigation(List<RouteConfig> routes) {
    if (routes.isEmpty || routes.every((element) => element.isChild)) return;
    write(_generateCommentBoxWithMessage(
        'Extension for strongly typed navigation'));

    writeLine("extension NavigatorStateExtension on NavigationService {");

    /// Generating the strongly typed navigation methods.
    generateStronglyTypedNavigationForRoutesAndChildren(routes);

    writeLine('}');
  }

  // to prevent duplicates we store the generated method names here
  final List<String> _generatedRoutes = [];

  void generateStronglyTypedNavigationForRoutesAndChildren(
      List<RouteConfig> routes,
      {String? parentClassName}) {
    for (var route in routes) {
      final name = parentClassName != null ? parentClassName : 'Routes';
      final methodName = (parentClassName != null)
          ? 'navigateToNested${route.className}'
          : 'navigateTo${route.className}';
      if (_generatedRoutes.contains(methodName)) continue;
      generateStronglyTypedNavigationReturnType(route);
      write('''$methodName( ''');
      _generatedRoutes.add(methodName);
      generateStronglyTypedNavigationParameters(route);
      writeLine(') async { return navigateTo(${name}.${route.name}, ');
      generateStronglyTypedNavigationRouteArguments(route);
      writeLine('); }');
      newLine();
      if (route.children.isNotEmpty) {
        generateStronglyTypedNavigationForRoutesAndChildren(
          route.children,
          parentClassName: capitalize(route.name + 'Routes'),
        );
      }
    }
  }

  void generateStronglyTypedNavigationReturnType(RouteConfig route) {
    writeLine(
        '''\nFuture<${route.isProcessedReturnTypeDynamic ? route.processedReturnType : '${route.processedReturnType}?'}>''');
  }

  void generateStronglyTypedNavigationParameters(RouteConfig route) {
    final params = route.notQueryAndNotPath;
    writeLine('{');
    if (params.isNotEmpty) {
      params.forEach((param) {
        if (param.isRequired || param.isPositional) {
          writeLine('required ${param.type} ${param.name}');
        } else {
          writeLine('${param.type} ${param.name}');
        }
        if (param.defaultValueCode != null) {
          write(' = ${param.defaultValueCode}');
        }
        write(',');
      });
    }
    writeLine('''
      int? routerId,
  bool preventDuplicates = true,
  Map<String, String>? parameters,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
      ''');
    writeLine('}');
  }

  void generateStronglyTypedNavigationRouteArguments(RouteConfig routeConfig) {
    final params = routeConfig.notQueryAndNotPath;
    final String className = routeConfig.isChild
        ? 'Nested${routeConfig.argumentsHolderClassName}'
        : routeConfig.argumentsHolderClassName;
    if (params.isNotEmpty) {
      writeLine('''
arguments: $className(
      ${params.map((param) => '${param.name}: ${param.name}').join(',')}
    ),
     
      ''');
    }
    writeLine(''' 
        id:routerId,
  preventDuplicates: preventDuplicates,
  parameters: parameters,
  transition: transition,
        ''');
  }

  String _generateCommentBoxWithMessage(String message) => '''

/// ************************************************************************
/// $message
/// *************************************************************************

''';
}
