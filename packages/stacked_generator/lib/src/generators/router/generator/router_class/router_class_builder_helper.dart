import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_parameter_config.dart';
import 'package:stacked_generator/utils.dart';

class RouterClassBuilderHelper {
  /// Example
  ///
  /// final _routes = <_i1.RouteDef>[
  ///   _i1.RouteDef(Routes.loginView, page: _i2.LoginClass),
  ///   _i1.RouteDef(Routes.homeView, page: _i3.HomeClass)
  /// ];
  Field listOfRoutes(List<RouteConfig> routes, String routesClassName) => Field(
        (b) => b
          ..name = '_routes'
          ..modifier = FieldModifier.final$
          ..assignment = _routes(routes, routesClassName),
      );

  Code _routes(List<RouteConfig> routes, String routesClassName) => literalList(
          _routesDef(routes, routesClassName),
          const Reference('RouteDef', 'package:stacked/stacked.dart'))
      .code;

  Iterable<Expression> _routesDef(
          List<RouteConfig> routes, String routesClassName) =>
      routes.map((route) =>
          const Reference('RouteDef', 'package:stacked/stacked.dart')
              .newInstance(
            [Reference(routesClassName).property(route.name ?? '')],
            {
              'page': Reference(route.className, route.classImport),
            },
          ));

  /// Example
  ///
  /// @override
  /// Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
  Method get pagesMapGetter => Method((b) => b
    ..name = 'pagesMap'
    ..annotations.add(const Reference('override'))
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
    ..body = const Reference('_pagesMap').code);

  /// Example
  ///
  /// @override
  /// List<_i1.RouteDef> get routes => _routes;
  Method get routesGetter => Method((b) => b
    ..name = 'routes'
    ..annotations.add(const Reference('override'))
    ..type = MethodType.getter
    ..returns = _listOfRouteDefReturnType
    ..body = const Reference('_routes').code);

  TypeReference get _listOfRouteDefReturnType => TypeReference((b) => b
    ..symbol = 'List'
    ..types.add(TypeReference((b) => b
      ..symbol = 'RouteDef'
      ..url = 'package:stacked/stacked.dart')));

  /// Example
  ///
  ///  final _pagesMap = <Type, _i1.StackedRouteFactory>{};
  Field mapOfPages(List<RouteConfig> routes) => Field(
        (b) => b
          ..name = '_pagesMap'
          ..modifier = FieldModifier.final$
          ..assignment = literalMap(
              _pages(routes),
              const Reference(
                'Type',
              ),
              const Reference(
                'StackedRouteFactory',
                'package:stacked/stacked.dart',
              )).code,
      );

  Map<Reference, Method> _pages(List<RouteConfig> routes) {
    return Map.fromEntries(
      routes.map(
        (route) => MapEntry(
          Reference(route.className, route.classImport),
          _getRouteRegisteration(route),
        ),
      ),
    );
  }

  Method _getRouteRegisteration(RouteConfig route) {
    final argsType = route.parentClassName != null
        ? 'Nested${route.argumentsHolderClassName}'
        : route.argumentsHolderClassName;

    final notQueryNorPathParameters = notQueryNorPath(route.parameters);

    return Method(
      (b) => b
        ..requiredParameters.add(Parameter(
          (b) => b..name = 'data',
        ))
        ..body = Block.of([
          if (notQueryNorPathParameters.isNotEmpty) ...[
            _prepareArgs(argsType),
            _eitherNullOkOrElse(
              route.parameters,
              argsType,
              hasConstConstructor: route.hasConstConstructor,
            ),
          ],
          _returnRouteRegistration(route),
        ]),
    );
  }

  Code _prepareArgs(String argsType) =>
      Code('final args = data.getArgs<$argsType>(');

  Code _eitherNullOkOrElse(List<ParamConfig> parameters, String argsType,
      {bool hasConstConstructor = false}) {
    /// if router has any required or positional params
    /// the argument class holder becomes required.
    final nullOk = parameters.any((p) => p.isRequired || p.isPositional);

    if (nullOk) {
      return const Code('nullOk: false);');
    } else {
      return Code('orElse: ()=> const $argsType(),);');
    }
  }

  /// Example
  ///
  /// return MaterialPageRoute<dynamic>(
  ///   builder: (context) => HomeView(
  ///     key: args.key,
  ///     title: args.title,
  ///   ),
  ///   settings: data,
  /// );
  Code _returnRouteRegistration(RouteConfig route) {
    if (route.routeType == RouteType.material) {
      return route.getRouteRegisterCode(
        routeType: 'MaterialPageRoute',
        routeTypeImport: 'package:flutter/material.dart',
      );
    } else if (route.routeType == RouteType.custom) {
      return route.getRouteRegisterCode(
        routeType: 'PageRouteBuilder',
        routeTypeImport: 'package:flutter/material.dart',
        usePageBuilder: true,
        extra: Block.of([
          if (!(route.customRouteOpaque ?? false))
            Code('opaque:${route.customRouteOpaque.toString()},'),
          if (route.customRouteBarrierDismissible ?? false)
            Code(
                'barrierDismissible:${route.customRouteBarrierDismissible.toString()},'),
          if (route.transitionBuilder != null) ...[
            const Code('transitionsBuilder: data.transition ?? '),
            Reference(route.transitionBuilder!.name,
                    route.transitionBuilder!.import)
                .code,
            const Code(',')
          ],
          if (route.transitionBuilder == null)
            const Code('''transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          },'''),
          if (route.durationInMilliseconds != null)
            Code(
                'transitionDuration: const Duration(milliseconds: ${route.durationInMilliseconds}),'),
          if (route.reverseDurationInMilliseconds != null)
            Code(
                'reverseTransitionDuration: const Duration(milliseconds: ${route.reverseDurationInMilliseconds}),'),
        ]),
      );
    } else if (route.routeType == RouteType.cupertino) {
      return route.getRouteRegisterCode(
          routeType: 'CupertinoPageRoute',
          routeTypeImport: 'package:flutter/cupertino.dart',
          extra: route.cupertinoNavTitle != null
              ? Code("title:'${route.cupertinoNavTitle}',")
              : null);
    } else if (route.routeType == RouteType.adaptive) {
      return route.getRouteRegisterCode(
        routeType: 'buildAdaptivePageRoute',
        routeTypeImport: 'package:stacked/stacked.dart',
        extra: route.cupertinoNavTitle != null
            ? Code("cupertinoTitle:'${route.cupertinoNavTitle}',")
            : null,
      );
    }

    throw Exception('No config registered for ${route.name} of type ');
  }
}
