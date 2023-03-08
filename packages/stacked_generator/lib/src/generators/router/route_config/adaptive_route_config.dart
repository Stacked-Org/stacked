import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';

class AdaptiveRouteConfig extends RouteConfig {
  const AdaptiveRouteConfig({
    required super.name,
    required super.pathName,
    required super.className,
    required super.classImport,
    super.fullscreenDialog,
    super.maintainState,
    super.returnType,
    super.parameters,
    super.hasWrapper,
    super.hasConstConstructor,
    super.children,
    super.imports,
    super.cupertinoNavTitle,
    super.parentClassName,
  });

  @override
  Code registerRoute() {
    return super.registerRouteBloc(
      routeType: 'buildAdaptivePageRoute',
      routeTypeImport: 'package:stacked/stacked.dart',
      extra: cupertinoNavTitle != null
          ? Code("cupertinoTitle:'$cupertinoNavTitle',")
          : null,
    );
  }
}
