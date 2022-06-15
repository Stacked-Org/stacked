import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/utils.dart';

class RouteConfig {
  final String name;
  final String pathName;
  final String className;
  final bool fullscreenDialog;
  final bool maintainState;
  final String? returnType;
  final List<RouteParamConfig> parameters;
  final List<RouteGuardConfig> guards;
  final bool hasWrapper;
  final List<RouteConfig> children;
  final bool hasConstConstructor;
  final Set<String> imports;
  final bool isChild;
  const RouteConfig({
    required this.name,
    required this.pathName,
    required this.className,
    this.isChild = false,
    this.fullscreenDialog = false,
    this.maintainState = true,
    this.returnType,
    this.parameters = const [],
    this.guards = const [],
    this.hasWrapper = false,
    this.children = const [],
    this.hasConstConstructor = false,
    this.imports = const {},
  });

  String get argumentsHolderClassName {
    return '${className}Arguments';
  }

  Set<String> registerImports() {
    final guardsImports = guards
        .where((guard) => guard.import != null)
        .map((guard) => guard.import!)
        .toSet();

    final paramertersImports = this
        .parameters
        .map((parameter) => parameter.imports)
        .fold<Set<String>>({}, (previousValue, element) {
      return {...previousValue, ...?element};
    });

    return {...this.imports, ...guardsImports, ...paramertersImports};
  }

  String registerArgs() {
    StringBuffer stringBuffer = StringBuffer();

    if (parameters.isNotEmpty) {
      // if router has any required or positional params the argument class holder becomes required.
      final nullOk =
          !notQueryAndNotPath.any((p) => p.isRequired || p.isPositional);
      // show an error page  if passed args are not the same as declared args

      if (notQueryAndNotPath.isNotEmpty) {
        final argsType = isChild
            ? 'Nested$argumentsHolderClassName'
            : argumentsHolderClassName;
        stringBuffer.writeln('var args = data.getArgs<$argsType>(');
        if (!nullOk) {
          stringBuffer.write('nullOk: false');
        } else {
          stringBuffer.write("orElse: ()=> $argsType(),");
        }
        stringBuffer.write(");");
      }
    }
    return stringBuffer.toString();
  }

  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();

    if (fullscreenDialog) {
      stringBuffer.write('fullscreenDialog:true,');
    }
    if (!maintainState) {
      stringBuffer.write('maintainState:false,');
    }
    stringBuffer.writeln(');');
    return stringBuffer.toString();
  }

  String? get templateName {
    return pathName.contains(":") ? '_$name' : name;
  }

  List<RouteParamConfig> get notQueryAndNotPath {
    return parameters.where((p) {
      throwIf(p.isPathParam == null || p.isQueryParam == null,
          ExceptionMessages.isPathParamAndIsQueryParamShouldNotBeNull);
      return !p.isPathParam! && !p.isQueryParam!;
    }).toList();
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
        "${hasConstConstructor == true ? 'const' : ''}  ${className}(${constructorParams.join(',')})${(hasWrapper) ? ".wrappedRoute(context)" : ""}";
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
    String? className,
    bool? fullscreenDialog,
    bool? maintainState,
    String? returnType,
    List<RouteParamConfig>? parameters,
    List<RouteGuardConfig>? guards,
    bool? hasWrapper,
    List<RouteConfig>? children,
    bool? hasConstConstructor,
    Set<String>? imports,
    bool? isChild,
  }) {
    return RouteConfig(
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      className: className ?? this.className,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      maintainState: maintainState ?? this.maintainState,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      guards: guards ?? this.guards,
      hasWrapper: hasWrapper ?? this.hasWrapper,
      children: children ?? this.children,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      imports: imports ?? this.imports,
      isChild: isChild ?? this.isChild,
    );
  }
}
