import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/utils.dart';

import '../exceptions/invalid_generator_input_exception.dart';

class RouterClassGenerator extends BaseGenerator {
  final RouterConfig _rootRouterConfig;

  RouterClassGenerator(this._rootRouterConfig);
  @override
  String generate() {
    writeLine("// ignore_for_file: public_member_api_docs");
    var allRouters = _rootRouterConfig.collectAllRoutersIncludingParent;
    var allRoutes = allRouters.fold<List<RouteConfig>>(
        [], (all, e) => all..addAll(e.routes ?? [])).toList();
    _generateImports(allRoutes);

    allRouters.forEach((routerConfig) {
      _generateRoutesClass(routerConfig);
      _generateRouterClass(routerConfig);

      if (_rootRouterConfig.generateNavigationHelper ?? false) {
        _generateNavigationHelpers(routerConfig);
      }
    });

    _generateArgumentHolders(allRoutes);

    return stringBuffer.toString();
  }

  void _generateImports(List<RouteConfig> routes) {
    // write route imports
    final imports = <String?>{
      "package:stacked/stacked.dart",
      if (routes.any((e) =>
          e.routeType == RouteType.material || e.routeType == RouteType.custom))
        "package:flutter/material.dart",
      if (routes.any((e) => e.routeType == RouteType.cupertino))
        "package:flutter/cupertino.dart",
    };
    routes.forEach((route) {
      imports.addAll(route.imports);
      if (route.transitionBuilder != null) {
        if (route.transitionBuilder!.import != null) {
          imports.add(route.transitionBuilder!.import);
        }
      }
      if (route.parameters != null) {
        route.parameters!.where((p) => p.imports != null).forEach((param) {
          imports.addAll(param.imports!);
        });
      }

      route.guards.forEach((g) => imports.add(g.import!));
    });

    var validImports =
        imports.where((import) => import != null).toSet().cast<String>();
    var dartImports =
        validImports.where((element) => element.startsWith('dart')).toSet();
    sortAndGenerate(dartImports);
    newLine();

    var packageImports =
        validImports.where((element) => element.startsWith('package')).toSet();
    sortAndGenerate(packageImports);
    newLine();

    var rest = validImports.difference({...dartImports, ...packageImports});
    sortAndGenerate(rest);
  }

  void _generateRoutesClass(RouterConfig routerConfig) {
    writeLine('class ${routerConfig.routesClassName} {');
    var allNames = <String>{};
    routerConfig.routes?.forEach((r) {
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
    routerConfig.routes?.forEach((r) {
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
    routerConfig.routes?.forEach((route) {
      throwIf(route.className == null,
          ExceptionMessages.RouteClassNameShouldnotBeNull);
      routesMap[route.className!] = route;
    });

    routesMap.forEach((name, route) {
      writeLine('$name: (data) {');
      _generateRoute(route);
      //close builder
      write("},");
    });
  }

  void _generateRoute(RouteConfig r) {
    List<String>? constructorParams = [];

    if (r.parameters?.isNotEmpty == true) {
      // if router has any required or positional params the argument class holder becomes required.
      final nullOk =
          !r.notQueryAndNotPath.any((p) => p.isRequired || p.isPositional);
      // show an error page  if passed args are not the same as declared args

      if (r.notQueryAndNotPath.isNotEmpty) {
        final argsType = r.argumentsHolderClassName;
        writeLine('var args = data.getArgs<$argsType>(');
        if (!nullOk) {
          write('nullOk: false');
        } else {
          write("orElse: ()=> $argsType(),");
        }
        write(");");
      }
      constructorParams = r.parameters?.map<String>((param) {
        String getterName;
        if (param.isPathParam ?? false) {
          getterName =
              "data.pathParams['${param.paramName}'].${param.getterName}(${param.defaultValueCode != null ? '${param.defaultValueCode}' : ''})";
        } else if (param.isQueryParam ?? false) {
          getterName =
              "data.queryParams['${param.paramName}'].${param.getterName}(${param.defaultValueCode != null ? '${param.defaultValueCode}' : ''})";
        } else {
          getterName = "args.${param.name}";
        }
        if (param.isPositional) {
          return getterName;
        } else {
          return '${param.name}:$getterName';
        }
      }).toList();
    }

    // add any empty item to add a comma at end
    // when join(',') is called
    if (constructorParams!.length > 1) {
      constructorParams.add('');
    }
    final constructor =
        "${r.hasConstConstructor == true ? 'const' : ''}  ${r.className}(${constructorParams.join(',')})${(r.hasWrapper ?? false) ? ".wrappedRoute(context)" : ""}";

    _generateRouteBuilder(r, constructor);
  }

  void _generateArgumentHolders(List<RouteConfig> routes) {
    final routesWithArgsHolders = Map<String, RouteConfig>();

    // make sure we only generated holder classes for
    // routes with parameters
    // also prevent duplicate class with the same name from being generated;

    routes
        .where((r) => r.notQueryAndNotPath.isNotEmpty)
        .forEach((r) => routesWithArgsHolders[r.className!] = r);

    if (routesWithArgsHolders.isNotEmpty) {
      _generateBoxed('Arguments holder classes');
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

  void _generateBoxed(String message) {
    writeLine('\n/// '.padRight(77, '*'));
    writeLine('/// $message');
    writeLine('/// '.padRight(77, '*'));
    newLine();
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

  void _generateRouteBuilder(RouteConfig r, String constructor) {
    if (r.returnType != null && r.returnType!.contains('<')) {
      if (r.returnType!.contains('CustomRoute') ||
          r.returnType!.contains('MaterialRoute') ||
          r.returnType!.contains('CupertinoRoute') ||
          r.returnType!.contains('AdaptiveRoute')) {
        // get the correct return type
        final type = r.returnType!.substring(
            r.returnType!.indexOf('<') + 1, r.returnType!.lastIndexOf('>'));
        r.returnType = type;
      }
    }
    final returnType = r.returnType ?? 'dynamic';
    if (r.routeType == RouteType.cupertino) {
      write(
          'return CupertinoPageRoute<$returnType>(builder: (context) => $constructor, settings: data,');
      if (r.cupertinoNavTitle != null) {
        write("title:'${r.cupertinoNavTitle}',");
      }
    } else if (r.routeType == RouteType.material) {
      write(
          'return MaterialPageRoute<$returnType>(builder: (context) => $constructor, settings: data,');
    } else if (r.routeType == RouteType.adaptive) {
      write(
          'return buildAdaptivePageRoute<$returnType>(builder: (context) => $constructor, settings: data,');
      if (r.cupertinoNavTitle != null) {
        write("cupertinoTitle:'${r.cupertinoNavTitle}',");
      }
    } else {
      write(
          'return PageRouteBuilder<$returnType>(pageBuilder: (context, animation, secondaryAnimation) => $constructor, settings: data,');

      if (r.customRouteOpaque != null) {
        write('opaque:${r.customRouteOpaque.toString()},');
      }
      if (r.customRouteBarrierDismissible != null) {
        write(
            'barrierDismissible:${r.customRouteBarrierDismissible.toString()},');
      }
      if (r.transitionBuilder != null) {
        write('transitionsBuilder: ${r.transitionBuilder!.name},');
      }
      if (r.durationInMilliseconds != null) {
        write(
            'transitionDuration: const Duration(milliseconds: ${r.durationInMilliseconds}),');
      }
      if (r.reverseDurationInMilliseconds != null) {
        write(
            'reverseTransitionDuration: const Duration(milliseconds: ${r.reverseDurationInMilliseconds}),');
      }
    }
    // generated shared props
    if (r.fullscreenDialog != null) {
      write('fullscreenDialog:${r.fullscreenDialog.toString()},');
    }
    if (r.maintainState != null) {
      write('maintainState:${r.maintainState.toString()},');
    }

    writeLine(');');
  }

  void _generateNavigationHelpers(RouterConfig routerConfig) {
    _generateBoxed('Navigation helper methods extension');
    writeLine(
        'extension ${routerConfig.routerClassName}ExtendedNavigatorStateX on ExtendedNavigatorState {');
    for (var route in routerConfig.routes ?? []) {
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
    if (route.parameters != null) {
      write('{');
      route.parameters?.forEach((param) {
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
    if (route.parameters != null) {
      write(',arguments: ');
      write('${route.argumentsHolderClassName}(');
      write(
          route.parameters?.map((p) => '${p.name}: ${p.name}').join(',') ?? '');
      write('),');

      if (route.guards.isNotEmpty == true) {
        write('onReject:onReject,');
      }
    }
    writeLine(');\n');
  }
}
