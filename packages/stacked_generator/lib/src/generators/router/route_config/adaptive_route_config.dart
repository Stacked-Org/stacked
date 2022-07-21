import 'route_config.dart';

class AdaptiveRouteConfig extends RouteConfig {
  final String? cupertinoNavTitle;

  const AdaptiveRouteConfig(
      {required super.name,
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
      this.cupertinoNavTitle,
      super.parentClassName});

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write(
        'return buildAdaptivePageRoute<$processedReturnType>(builder: (context) => $joinedConstructerParams, settings: data,');
    if (cupertinoNavTitle != null) {
      stringBuffer.write("cupertinoTitle:'${cupertinoNavTitle}',");
    }
    stringBuffer.write(super.registerRoutes());

    return stringBuffer.toString();
  }
}
