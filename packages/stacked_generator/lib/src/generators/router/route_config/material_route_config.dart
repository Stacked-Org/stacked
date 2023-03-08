import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';

class MaterialRouteConfig extends RouteConfig {
  const MaterialRouteConfig({
    required super.name,
    required super.classImport,
    required super.pathName,
    required super.className,
    super.fullscreenDialog,
    super.maintainState,
    super.returnType,
    super.parameters,
    super.hasWrapper,
    super.hasConstConstructor,
    super.children,
    super.imports,
    super.parentClassName,
  });

  Code registerRoute() {
    return super.getRouteRegisterCode(
      routeType: 'MaterialPageRoute',
    );
  }
}
