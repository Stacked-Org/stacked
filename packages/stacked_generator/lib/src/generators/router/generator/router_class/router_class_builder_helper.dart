import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/route_config/route_config.dart';

class RouterClassBuilderHelper {
  ///   Example
  ///
  /// final _routes = <_i1.RouteDef>[
  ///   _i1.RouteDef(Routes.loginView, page: _i2.LoginClass),
  ///   _i1.RouteDef(Routes.homeView, page: _i3.HomeClass)
  /// ];
  Field listOfRoutes(List<RouteConfig> routes) => Field(
        (b) => b
          ..name = '_routes'
          ..modifier = FieldModifier.final$
          ..assignment = _assigneeListOfRoutes(routes),
      );

  Code _assigneeListOfRoutes(List<RouteConfig> routes) => literalList(
          _routesDef(routes),
          Reference('RouteDef', 'package:stacked/stacked.dart'))
      .code;

  Iterable<Expression> _routesDef(List<RouteConfig> routes) =>
      routes.map((route) =>
          Reference('RouteDef', 'package:stacked/stacked.dart').newInstance(
            [Reference('Routes').property(route.name)],
            {
              'page': Reference(route.className.key, route.className.value),
            },
          ));

  /// Example
  ///
  /// @override
  /// Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
  Method get pagesMapGetter => Method((b) => b
    ..name = 'pagesMap'
    ..annotations.add(Reference('override'))
    ..type = MethodType.getter
    ..returns = TypeReference((b) => b
      ..symbol = 'Map'
      ..types.addAll([
        TypeReference(
          (b) => b..symbol = 'Type',
        ),
        TypeReference(
          (b) => b
            ..symbol = 'StackedRouteFactory'
            ..url = 'package:stacked/stacked.dart',
        ),
      ]))
    ..body = Reference('_pagesMap').code);

  /// Example
  ///
  /// @override
  /// List<_i1.RouteDef> get routes => _routes;
  Method get routesGetter => Method((b) => b
    ..name = 'routes'
    ..annotations.add(Reference('override'))
    ..type = MethodType.getter
    ..returns = _listOfRouteDefReturnType
    ..body = Reference('_routes').code);

  TypeReference get _listOfRouteDefReturnType => TypeReference((b) => b
    ..symbol = 'List'
    ..types.add(TypeReference((b) => b
      ..symbol = 'RouteDef'
      ..url = 'package:stacked/stacked.dart'
      ..isNullable = true)));
}
