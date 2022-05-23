import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:source_gen/source_gen.dart';

import 'router_config.dart';

const TypeChecker stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

// extracts route configs from class fields
class RouteConfigResolver {
  final RouterConfig _routerConfig;
  final ImportResolver _importResolver;

  const RouteConfigResolver(this._routerConfig, this._importResolver);

  Future<RouteConfig> resolve(ConstantReader stackedRoute) async {
    return RouteConfig.fromStackedApp(
        stackedRoute, _importResolver, _routerConfig);
  }
}
