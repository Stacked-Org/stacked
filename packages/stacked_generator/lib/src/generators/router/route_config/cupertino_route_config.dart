import '../models/route_guard_config.dart';
import '../models/route_parameter_config.dart';
import 'route_config.dart';

class CupertinoRouteConfig extends RouteConfig {
  final String name;
  final String pathName;
  final String className;
  final bool fullscreenDialog;
  final bool maintainState;
  final String? returnType;
  final List<RouteParamConfig> parameters;
  final List<RouteGuardConfig> guards;
  final bool hasWrapper;
  final bool hasConstConstructor;
  final List<RouteConfig> children;
  final Set<String> imports;
  final bool isChild;
  final String? cupertinoNavTitle;

  const CupertinoRouteConfig({
    required this.name,
    required this.pathName,
    required this.className,
    this.fullscreenDialog = false,
    this.maintainState = true,
    this.returnType,
    this.parameters = const [],
    this.guards = const [],
    this.hasWrapper = false,
    this.hasConstConstructor = false,
    this.children = const [],
    this.imports = const {},
    this.cupertinoNavTitle,
    this.isChild = false,
  }) : super(
          imports: imports,
          hasConstConstructor: hasConstConstructor,
          name: name,
          pathName: pathName,
          className: className,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          returnType: returnType,
          parameters: parameters,
          guards: guards,
          hasWrapper: hasWrapper,
          children: children,
          isChild: isChild,
        );

  @override
  Set<String> registerImports() {
    return {...super.registerImports(), "package:flutter/cupertino.dart"};
  }

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write(super.registerArgs());
    stringBuffer.write(
        'return CupertinoPageRoute<$processedReturnType>(builder: (context) => $joinedConstructerParams, settings: data,');
    if (cupertinoNavTitle != null) {
      stringBuffer.write("title:'$cupertinoNavTitle',");
    }
    stringBuffer.write(super.registerRoutes());
    return stringBuffer.toString();
  }

  CupertinoRouteConfig copyWith({
    String? name,
    String? pathName,
    String? className,
    bool? fullscreenDialog,
    bool? maintainState,
    String? returnType,
    List<RouteParamConfig>? parameters,
    List<RouteGuardConfig>? guards,
    bool? hasWrapper,
    bool? hasConstConstructor,
    List<RouteConfig>? children,
    Set<String>? imports,
    String? cupertinoNavTitle,
    bool? isChild,
  }) {
    return CupertinoRouteConfig(
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      className: className ?? this.className,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      maintainState: maintainState ?? this.maintainState,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      guards: guards ?? this.guards,
      hasWrapper: hasWrapper ?? this.hasWrapper,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      children: children ?? this.children,
      imports: imports ?? this.imports,
      cupertinoNavTitle: cupertinoNavTitle ?? this.cupertinoNavTitle,
      isChild: isChild ?? this.isChild,
    );
  }
}
