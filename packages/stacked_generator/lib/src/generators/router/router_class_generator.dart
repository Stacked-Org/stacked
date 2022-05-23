import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/router/route_generator_helper.dart';
import 'package:stacked_generator/utils.dart';

import 'router_config.dart';

class RouterClassGenerator extends BaseGenerator with RouteGeneratorHelper {
  final RouterConfig _rootRouterConfig;

  RouterClassGenerator(this._rootRouterConfig);
  @override
  String generate() {
    writeLine("// ignore_for_file: public_member_api_docs");
    var allRouters = _rootRouterConfig.collectAllRoutersIncludingParent;
    var allRoutes = allRouters.fold<List<RouteConfig>>(
        [], (all, e) => all..addAll(e.routes)).toList();
    _generateImports(allRoutes);

    allRouters.forEach((routerConfig) {
      _generateRoutesClass(routerConfig);
      _generateRouterClass(routerConfig);

      if (_rootRouterConfig.generateNavigationHelper) {
        _generateNavigationHelpers(routerConfig);
      }
    });

    _generateArgumentHolders(allRoutes);

    return stringBuffer.toString();
  }

  void _generateImports(List<RouteConfig> routes) {
    final validImports = routes.map((rc) {
      return rc.registerImports();
    }).where((imports) {
      return imports.isNotEmpty;
    }).fold<Set<String>>({}, (previousValue, element) {
      return {...previousValue, ...element};
    });

    final dartImports =
        validImports.where((element) => element.startsWith('dart')).toSet();
    sortAndGenerate(dartImports);
    newLine();

    var packageImports =
        validImports.where((element) => element.startsWith('package')).toSet();
    packageImports.add("package:stacked/stacked.dart");
    sortAndGenerate(packageImports);
    newLine();

    var rest = validImports.difference({...dartImports, ...packageImports});
    sortAndGenerate(rest);
  }

  void _generateRoutesClass(RouterConfig routerConfig) {
    writeLine('class ${routerConfig.routesClassName} {');
    var allNames = <String>{};
    routerConfig.routes.forEach((r) {
      final routeName = r.name;
      final path = r.pathName;

      if (path.contains(':')) {
        // handle template paths
        writeLine("static const String _$routeName = '$path';");
        allNames.add('_$routeName');
        var params = RegExp(r':([^/]+)').allMatches(path).map((m) {
          var match = m.group(1);
          if (match!.endsWith('?')) {
            return "dynamic  ${match.substring(0, match.length - 1)} = ''";
          } else {
            return "@required  dynamic $match";
          }
        });
        writeLine(
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
        writeLine("static const String $routeName = '$path';");
      }
    });
    writeLine("static const all = <String>{");
    allNames.forEach((name) => write('$name,'));
    write("};");
    writeLine('}');
  }

  void _generateRouteTemplates(RouterConfig routerConfig) {
    newLine();
    routerConfig.routes.forEach((r) {
      writeLine("RouteDef(${routerConfig.routesClassName}.${r.templateName}");
      writeLine(",page: ${r.className}");
      if (r.guards.isNotEmpty == true) {
        writeLine(",guards:${r.guards.map((e) => e.type).toList().toString()}");
      }
      if (r.routerConfig != null) {
        writeLine(",generator: ${r.routerConfig!.routerClassName}(),");
      }
      writeLine('),');
    });
  }

  void _generateRouteGeneratorFunction(RouterConfig routerConfig) {
    newLine();

    var routesMap = <String, RouteConfig>{};
    routerConfig.routes.forEach((route) {
      // throwIf(route.className == null,
      //     ExceptionMessages.RouteClassNameShouldnotBeNull);
      routesMap[route.className] = route;
    });

    routesMap.forEach((name, route) {
      writeLine('$name: (data) {');
      write(route.registerRoutes());
      //close builder
      write("},");
    });
  }

  void _generateArgumentHolders(List<RouteConfig> routes) {
    final routesWithArgsHolders = Map<String, RouteConfig>();

    // make sure we only generated holder classes for
    // routes with parameters
    // also prevent duplicate class with the same name from being generated;

    routes
        .where((r) => r.notQueryAndNotPath.isNotEmpty)
        .forEach((r) => routesWithArgsHolders[r.className] = r);

    if (routesWithArgsHolders.isNotEmpty) {
      write(generateCommentBoxWithMessage('Arguments holder classes'));
      routesWithArgsHolders.values.forEach(_generateArgsHolder);
    }
  }

  void _generateArgsHolder(RouteConfig routeConfig) {
    writeLine('/// ${routeConfig.className} arguments holder class');
    final argsClassName = '${routeConfig.argumentsHolderClassName}';

    // generate fields
    writeLine('class $argsClassName{');
    final params = routeConfig.notQueryAndNotPath;
    params.forEach((param) {
      writeLine('final ${param.type} ${param.name};');
    });

    // generate constructor
    writeLine('$argsClassName({');
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

  void _generateRouterClass(RouterConfig routerConfig) {
    writeLine('\nclass ${routerConfig.routerClassName} extends RouterBase {');

    writeLine('''
     @override
     List<RouteDef> get routes => _routes;
     final _routes = <RouteDef>[
     ''');
    _generateRouteTemplates(routerConfig);
    write('];');

    writeLine('''
       @override
       Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
        final _pagesMap = <Type, StackedRouteFactory>{
        ''');
    _generateRouteGeneratorFunction(routerConfig);
    write('};');

    // close router class
    writeLine('}');
  }

  void _generateNavigationHelpers(RouterConfig routerConfig) {
    write(generateCommentBoxWithMessage('Navigation helper methods extension'));
    writeLine(
        'extension ${routerConfig.routerClassName}ExtendedNavigatorStateX on ExtendedNavigatorState {');
    for (var route in routerConfig.routes) {
      // skip routes that has path params until
      // until there's a practical way to handle them
      if (RegExp(r':([^/]+)').hasMatch(route.pathName)) {
        continue;
      }
      _generateHelperMethod(route, routerConfig.routesClassName!);
    }
    writeLine('}');
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
      if (route.guards.isNotEmpty == true) {
        write('OnNavigationRejected onReject');
      }
      write('}');
    }
    writeLine(')');
    write(' => push$genericType($routesClassName.${route.name}');
    if (route.parameters.isNotEmpty) {
      write(',arguments: ');
      write('${route.argumentsHolderClassName}(');
      write(route.parameters.map((p) => '${p.name}: ${p.name}').join(','));
      write('),');

      if (route.guards.isNotEmpty == true) {
        write('onReject:onReject,');
      }
    }
    writeLine(');\n');
  }
}
