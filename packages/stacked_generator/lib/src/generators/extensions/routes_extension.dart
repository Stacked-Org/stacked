import '../../../utils.dart';
import '../router/router_config/router_config.dart';

extension RoutesExtension on RouterConfig {
  void traverseRoutes(void Function(RouterConfig routerConfig) performAction) {
    performAction(this);

    for (var route in this.routes) {
      // if (route.children.isEmpty) continue;

      RouterConfig(
              routes: route.children,
              routerClassName: capitalize(route.name + 'Router'),
              routesClassName: capitalize(route.name + 'Routes'))
          .traverseRoutes(performAction);
    }
  }
}
