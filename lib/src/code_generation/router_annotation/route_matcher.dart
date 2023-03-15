import 'package:flutter/widgets.dart';

import 'parameters.dart';
import 'route_def.dart';
import 'uri_extension.dart';

class RouteMatcher {
  final Uri _uri;
  final RouteSettings? _settings;

  RouteMatcher(RouteSettings this._settings)
      : _uri = Uri.parse(_settings.name!);

  RouteMatcher.fromUri(this._uri) : _settings = null;

  RouteMatchV1? match(RouteDef route, {bool fullMatch = false}) {
    var pattern = fullMatch ? '${route.pattern}\$' : route.pattern;
    var match = RegExp(pattern as String).stringMatch(_uri.path);
    RouteMatchV1? matchResult;
    if (match != null) {
      // strip trailing forward slash
      if (match.endsWith("/") && match.length > 1) {
        match = match.substring(0, match.length - 1);
      }

      var segment = _uri.replace(path: match);
      var rest = _uri.replace(path: _uri.path.substring(match.length));
      // return null if the rest of the provided uri doesn't match
      // any of the nested routes
      if (!rest.hasEmptyPath) {
        if (route.isParent) {
          if (!route.generator!.hasMatch(rest.path)) {
            return null;
          }
        } else {
          return null;
        }
      }

      // passing args to the last destination
      // when pushing deep links
      var args = _settings?.arguments;
      Object? argsToPass;
      if (!rest.hasEmptyPath) {
        argsToPass = args;
        args = null;
      }

      matchResult = RouteMatchV1(
          name: !rest.hasEmptyPath || !segment.hasQueryParams || route.isParent
              ? segment.path
              : segment.toString(),
          arguments: args,
          initialArgsToPass: argsToPass,
          uri: segment,
          routeDef: route,
          rest: rest,
          pathParamsMap: _extractPathParams(route.pattern as String, match));
    }
    return matchResult;
  }

  Map<String, String?> _extractPathParams(String pathPattern, String path) {
    var pathMatch = RegExp(pathPattern).firstMatch(path);
    var params = <String, String?>{};
    if (pathMatch != null) {
      for (var name in pathMatch.groupNames) {
        params[name] = pathMatch.namedGroup(name);
      }
    }
    return params;
  }
}

@immutable
class RouteMatchV1 extends RouteSettings {
  final Uri uri;
  final RouteDef routeDef;
  final Uri rest;
  final Map<String, String?> pathParamsMap;
  final Object? initialArgsToPass;

  const RouteMatchV1({
    required this.uri,
    required this.routeDef,
    required this.rest,
    required this.pathParamsMap,
    this.initialArgsToPass,
    required String? name,
    required Object? arguments,
  }) : super(name: name, arguments: arguments);

  bool get hasRest => !rest.hasEmptyPath;

  bool get isParent => routeDef.generator != null;

  String get template => routeDef.template;

  String get path => uri.path;

  Parameters get queryParams => Parameters(uri.queryParameters);

  Parameters get pathParams => Parameters(pathParamsMap);

  RouteSettings copyWith({
    String? name,
    Object? arguments,
  }) {
    return RouteMatchV1(
        name: name ?? this.name,
        arguments: arguments ?? this.arguments,
        initialArgsToPass: initialArgsToPass,
        uri: uri,
        routeDef: routeDef,
        rest: rest,
        pathParamsMap: pathParamsMap);
  }
}
