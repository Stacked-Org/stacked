import 'route_config.dart';

class MaterialRouteConfig extends RouteConfig {
  const MaterialRouteConfig(
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
      super.isChild});

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(super.registerArgs());
    stringBuffer.write(
        'return MaterialPageRoute<$processedReturnType>(builder: (context) => $joinedConstructerParams, settings: data,');
    stringBuffer.write(super.registerRoutes());
    return stringBuffer.toString();
  }
}
