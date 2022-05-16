import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/route_factory.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

// extracts route configs from class fields
class RouteConfigResolver {
  final RouterConfig _routerConfig;
  final ImportResolver _importResolver;

  const RouteConfigResolver(this._routerConfig, this._importResolver);

  Future<RouteConfig> resolve(ConstantReader stackedRoute) async {
    final dartType = stackedRoute.read('page').typeValue;
    final routeConfig = RouteConfig();

    final routeFactory = RouteFactory(
            globalRouteConfig: _routerConfig.globalRouteConfig,
            stackedRoute: stackedRoute,
            dartType: dartType,
            importResolver: _importResolver,
            routeNamePrefix: _routerConfig.routeNamePrefix,
            routeConfig: routeConfig)
        .build();

    return routeFactory;
  }
}
