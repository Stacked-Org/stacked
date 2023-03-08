import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';

class CupertinoRouteConfig extends RouteConfig {
  const CupertinoRouteConfig({
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
    super.parentClassName,
    super.cupertinoNavTitle,
  });

  Code registerRoute() {
    return super.getRouteRegisterCode(
        routeType: 'CupertinoPageRoute',
        routeTypeImport: 'package:flutter/cupertino.dart',
        extra: cupertinoNavTitle != null
            ? Code("title:'$cupertinoNavTitle',")
            : null);
  }
}
