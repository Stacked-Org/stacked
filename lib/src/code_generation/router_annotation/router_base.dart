import 'route_data.dart';
import 'route_def.dart';

import 'package:flutter/widgets.dart';
import 'route_matcher.dart';

typedef StackedRouteFactory = Route<dynamic> Function(RouteDataV1 data);
typedef RouterBuilder<T extends RouterBase> = T Function();

abstract class RouterBase {
  List<RouteDef> get routes;

  Map<Type, StackedRouteFactory> get pagesMap;

  Set<String> get allRoutes => routes.map((e) => e.template).toSet();

  Route<dynamic>? onGenerateRoute(RouteSettings settings, [String? basePath]) {
    var match = findMatch(settings);
    if (match != null) {
      if (basePath != null) {
        match = match.copyWith(name: _joinPath(basePath, match.name))
            as RouteMatchV1?;
      }

      RouteDataV1 data;
      if (match!.isParent) {
        data = ParentRouteData(
          matchResult: match,
          initialRoute: match.rest,
          router: match.routeDef.generator,
        );
      } else {
        data = RouteDataV1(match);
      }
      return pagesMap[match.routeDef.page!]!(data);
    }
    return null;
  }

  String _joinPath(String basePath, String? part) {
    String name;
    var pathOnly = Uri.parse(basePath).path;
    if (part == "" || pathOnly.endsWith("/") || part!.startsWith("/")) {
      name = "$pathOnly$part";
    } else {
      name = "$pathOnly/$part";
    }
    return name;
  }

  // a shorthand for calling the onGenerateRoute function
  // when using Router directly in MaterialApp or such
  // Router().onGenerateRoute becomes Router()
  Route<dynamic>? call(RouteSettings settings) => onGenerateRoute(settings);

  RouteMatchV1? findMatch(RouteSettings settings) {
    var matcher = RouteMatcher(settings);
    for (var route in routes) {
      var match = matcher.match(route);
      if (match != null) {
        // matching root "/" must be exact
        if ((route.template == "/" || route.template.isEmpty) &&
            match.hasRest) {
          continue;
        }
        return match;
      }
    }
    return null;
  }

  bool hasMatch(String path) {
    return findMatch(RouteSettings(name: path)) != null;
  }

  List<RouteMatchV1> allMatches(RouteMatcher matcher) {
    var matches = <RouteMatchV1>[];
    for (var route in routes) {
      var matchResult = matcher.match(route);
      if (matchResult != null) {
        matches.add(matchResult);
        if (matchResult.isParent || !matchResult.hasRest) {
          break;
        }
      }
    }
    return matches;
  }
}
