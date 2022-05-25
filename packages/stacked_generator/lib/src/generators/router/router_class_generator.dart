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
    _generateImports(_rootRouterConfig.routes);

    write(generateRoutesConstantsMap(
      _rootRouterConfig.routes,
      _rootRouterConfig.routesClassName,
    ));

    write(generateRouterClass(
      _rootRouterConfig.routes,
      _rootRouterConfig.routerClassName,
      _rootRouterConfig.routesClassName,
    ));

    if (_rootRouterConfig.generateNavigationHelper) {
      _generateNavigationHelpers(_rootRouterConfig.routes,
          _rootRouterConfig.routerClassName, _rootRouterConfig.routesClassName);
    }

    _generateArgumentHolders(_rootRouterConfig.routes);

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

  void _generateNavigationHelpers(
    List<RouteConfig> routes,
    String routerClassName,
    String routesClassName,
  ) {
    write(generateCommentBoxWithMessage('Navigation helper methods extension'));
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
