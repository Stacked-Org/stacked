import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

import '../router_common/models/router_config.dart';

extension RoutesExtension on RouterConfig {
  void traverseRoutes(void Function(RouterConfig routerConfig) performAction) {
    performAction(this);

    for (var route in routes) {
      RouterConfig(
        routes: route.children,
        routerClassName: '${route.name}Router'.capitalize,
        routesClassName: '${route.name}Routes'.capitalize,
      ).traverseRoutes(performAction);
    }
  }
}
