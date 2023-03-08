import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';

class RoutesClassBuilder {
  final List<RouteConfig> routes;
  final String routesClassName;
  const RoutesClassBuilder({
    required this.routes,
    required this.routesClassName,
  });

  /// Example result
  ///
  /// class RoutesClassName {
  /// static const String loginView = 'pathNamaw';
  /// static const String _homeView = '/family/:fid';
  /// static String homeView({@required dynamic fid}) => '/family/\$fid';
  /// static const all = <String>{
  /// loginView,_homeView,};}
  ///
  Class buildRoutesClass() {
    final assignPathsToRouteNames = routes.map((route) {
      print(
          '============ assignPathsToRouteNames | pathName:${route.pathName} name:${route.name}');
      return Field(
        (b) => b
          ..modifier = FieldModifier.constant
          ..static = true
          ..name = _convertToPrivateNameWhenRouteHasPathParameter(route)
          ..assignment = literalString(route.pathName).code,
      );
    });

    final pathMethods =
        routes.where((route) => route.pathName.contains(':')).map((route) {
      return Method(
        (b) => b
          ..returns = const Reference('String')
          ..static = true
          ..lambda = true
          ..optionalParameters
              .addAll(_extractOptionalParameters(route.pathName))
          ..name = route.name
          ..body = Code(_addRouteWithPathParameter(
              routeName: route.name ?? '', routePath: route.pathName)),
      );
    });

    final allField = Field(
      (b) => b
        ..modifier = FieldModifier.constant
        ..static = true
        ..name = 'all'
        ..assignment = literalSet(
                routes.map((route) => Reference(
                    _convertToPrivateNameWhenRouteHasPathParameter(route))),
                const Reference('String'))
            .code,
    );

    return Class((b) => b
      ..name = routesClassName
      ..methods.addAll(pathMethods)
      ..fields.addAll([...assignPathsToRouteNames, allField]));
  }

  String _convertToPrivateNameWhenRouteHasPathParameter(RouteConfig route) {
    return route.pathName.contains(':') ? '_${route.name}' : route.name ?? '';
  }

  Iterable<Parameter> _extractOptionalParameters(String pathName) {
    return RegExp(r':([^/]+)').allMatches(pathName).map((m) {
      final match = m.group(1);
      if (match!.endsWith('?')) {
        return Parameter((b) => b
          ..named = true
          ..type = const Reference('dynamic')
          ..name = match.substring(0, match.length - 1));
      } else {
        return Parameter((b) => b
          ..required = true
          ..named = true
          ..type = const Reference('dynamic')
          ..name = match);
      }
    });
  }

  String _addRouteWithPathParameter(
      {required String routePath, required String routeName}) {
    final pathAfterAddingDollarSigns =
        routePath.replaceAllMapped(RegExp(r'([:])|([?])'), (m) {
      if (m[1] != null) {
        return '\$';
      } else {
        return '';
      }
    });
    return "'$pathAfterAddingDollarSigns'";
  }
}
