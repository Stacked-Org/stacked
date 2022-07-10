import '../models/route_parameter_config.dart';
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
      super.isChild});

  @override
  Set<String> registerImports() {
    return {...super.registerImports()};
  }

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write(super.registerArgs());
    stringBuffer.write(
        'return buildAdaptivePageRoute<$processedReturnType>(builder: (context) => $joinedConstructerParams, settings: data,');
    if (cupertinoNavTitle != null) {
      stringBuffer.write("cupertinoTitle:'${cupertinoNavTitle}',");
    }
    stringBuffer.write(super.registerRoutes());

    return stringBuffer.toString();
  }

  AdaptiveRouteConfig copyWith({
    String? name,
    String? pathName,
    String? className,
    bool? fullscreenDialog,
    bool? maintainState,
    String? returnType,
    List<RouteParamConfig>? parameters,
    bool? hasWrapper,
    bool? hasConstConstructor,
    List<RouteConfig>? children,
    Set<String>? imports,
    String? cupertinoNavTitle,
    bool? isChild,
  }) {
    return AdaptiveRouteConfig(
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      className: className ?? this.className,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      maintainState: maintainState ?? this.maintainState,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      hasWrapper: hasWrapper ?? this.hasWrapper,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      children: children ?? this.children,
      imports: imports ?? this.imports,
      cupertinoNavTitle: cupertinoNavTitle ?? this.cupertinoNavTitle,
    );
  }
}
