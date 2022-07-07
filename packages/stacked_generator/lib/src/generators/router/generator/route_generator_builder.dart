import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';

const _constImports = [
  "package:stacked/stacked.dart",
  "package:stacked_services/stacked_services.dart"
];

class RouteGeneratorBuilder with StringBufferUtils {
  final List<RouteConfig> routes;
  final String routesClassName;
  RouteGeneratorBuilder({required this.routes, required this.routesClassName});

  RouteGeneratorBuilder addHeaderComment() {
    write(
        "// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names");
    return this;
  }

  /// Example result
  ///
  /// import 'package:importone.dart';
  /// import 'package:importtwo.dart';
  /// import 'package:ClashTypeOne/ClashType.dart';
  /// import 'package:flutter/material.dart';
  /// import 'package:ClashTypeTwo/ClashType.dart';
  /// import 'package:stacked/stacked.dart';
  /// import 'package:stacked_services/stacked_services.dart';
  RouteGeneratorBuilder sortAndAddImports() {
    final allImports = routes
        .map((route) => route.registerImports())
        .fold<Set<String>>(
            {}, (previousValue, element) => {...previousValue, ...element});

    final dartImports =
        allImports.where((element) => element.startsWith('dart'));
    generateAndAddNewLines(dartImports, preLines: 1, postlines: 1);

    final packageImports =
        allImports.where((element) => element.startsWith('package'));
    generateAndAddNewLines([...packageImports, ..._constImports], postlines: 1);

    final remainingImports =
        allImports.difference({...dartImports, ...packageImports});
    generateAndAddNewLines(remainingImports);

    return this;
  }

  /// Example result
  ///
  /// class RoutesClassName {
  /// static const String loginView = 'pathNamaw';
  /// static const String homeView = 'pathNamaw';
  /// static const all = <String>{
  /// loginView,homeView,};}
  ///
  RouteGeneratorBuilder addRoutesClassName() {
    writeLine('class $routesClassName {');

    for (var route in routes) {
      writeLine("static const String ${route.name} = '${route.pathName}';");
    }

    writeLine("static const all = <String>{");

    for (var route in routes) {
      write('${route.name},');
    }

    // Closes the [all] map
    write("};");

    // Closes the [routesClassName] class
    writeLine('}');
    return this;
  }

  _addRouteWithPath(String routePath, String routeName) {
    if (routePath.contains(':')) {
      // handle template paths
      writeLine("static const String _$routeName = '$routePath';");
      // allNames.add('_$routeName');
      var params = RegExp(r':([^/]+)').allMatches(routePath).map((m) {
        var match = m.group(1);
        if (match!.endsWith('?')) {
          return "dynamic  ${match.substring(0, match.length - 1)} = ''";
        } else {
          return "@required  dynamic $match";
        }
      });
      writeLine(
        "static String $routeName({${params.join(',')}}) => '${routePath.replaceAllMapped(RegExp(r'([:])|([?])'), (m) {
          if (m[1] != null) {
            return '\$';
          } else {
            return '';
          }
        })}';",
      );
    }
  }
}
