import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/route_config_resolver.dart';

abstract class RouteConfig {
  final String name;
  final String pathName;
  final MapEntry<String, String> className;
  final bool fullscreenDialog;
  final bool maintainState;
  final String? returnType;
  final List<RouteParamConfig> parameters;
  final bool hasWrapper;
  final List<RouteConfig> children;
  final bool hasConstConstructor;
  final Set<String> imports;
  final String? parentClassName;
  const RouteConfig({
    required this.name,
    required this.pathName,
    required this.className,
    this.parentClassName,
    this.fullscreenDialog = false,
    this.maintainState = true,
    this.returnType,
    this.parameters = const [],
    this.hasWrapper = false,
    this.children = const [],
    this.hasConstConstructor = false,
    this.imports = const {},
  });

  String get argumentsHolderClassName {
    return '${className.key}Arguments';
  }

  Code registerRoutes() {
    return Block.of([
      if (fullscreenDialog) Code('fullscreenDialog:true,'),
      if (!maintainState) Code('maintainState:false,'),
      Code(');')
    ]);
  }

  String get joinedConstructerParams {
    List<String>? constructorParams = parameters.map<String>((param) {
      String getterName;
      if (param.isPathParam ?? false) {
        getterName =
            "data.pathParams['${param.paramName}'].${param.getterName}(${param.defaultValueCode != null ? '${param.defaultValueCode}' : ''})";
      } else if (param.isQueryParam ?? false) {
        getterName =
            "data.queryParams['${param.paramName}'].${param.getterName}(${param.defaultValueCode != null ? '${param.defaultValueCode}' : ''})";
      } else {
        getterName = "args.${param.name}";
      }
      if (param.isPositional) {
        return getterName;
      } else {
        return '${param.name}:$getterName';
      }
    }).toList();
    // add any empty item to add a comma at end
    // when join(',') is called
    if (constructorParams.length > 1) {
      constructorParams.add('');
    }
    final constructor =
        "${hasConstConstructor == true ? 'const' : ''}  ${className.key}(${constructorParams.join(',')})${(hasWrapper) ? ".wrappedRoute(context)" : ""}";
    return constructor;
  }

  bool get isProcessedReturnTypeDynamic => processedReturnType == 'dynamic';

  String get processedReturnType {
    final returnTypeContainsBiggerOperatorWithOneOfRouteNames = returnType !=
            null &&
        returnType!.contains('<') &&
        returnType!.contains(
            RegExp('CustomRoute|MaterialRoute|CupertinoRoute|AdaptiveRoute'));

    if (returnTypeContainsBiggerOperatorWithOneOfRouteNames) {
      final afterRemovingArrowHeads = returnType!.substring(
          returnType!.indexOf('<') + 1, returnType!.lastIndexOf('>'));

      return afterRemovingArrowHeads;
    } else {
      return returnType ?? 'dynamic';
    }
  }

  RouteConfig copyWith({
    String? name,
    String? pathName,
    MapEntry<String, String>? className,
    bool? fullscreenDialog,
    bool? maintainState,
    String? returnType,
    List<RouteParamConfig>? parameters,
    bool? hasWrapper,
    List<RouteConfig>? children,
    bool? hasConstConstructor,
    Set<String>? imports,
    String? parentClassName,
  });
}
