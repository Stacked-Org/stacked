import 'route_config.dart';

class CupertinoRouteConfig extends RouteConfig {
  final String? cupertinoNavTitle;

  const CupertinoRouteConfig(
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
      super.isChild});

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write(
        'return CupertinoPageRoute<$processedReturnType>(builder: (context) => $joinedConstructerParams, settings: data,');
    if (cupertinoNavTitle != null) {
      stringBuffer.write("title:'$cupertinoNavTitle',");
    }
    stringBuffer.write(super.registerRoutes());
    return stringBuffer.toString();
  }
}
