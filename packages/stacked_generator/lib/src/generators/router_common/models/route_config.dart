import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_2/route_utils.dart';

import '../../router_2/models/router_config.dart';
import 'importable_type.dart';
import 'route_parameter_config.dart';

/// holds the extracted route configs
/// to be used in [RouterClassGenerator]

class RouteConfig {
  final String? name;
  final String pathName;
  final String className;
  final String classImport;
  final bool fullscreenDialog;
  final bool maintainState;
  final ResolvedType? returnType;
  final List<ParamConfig> parameters;
  final bool hasWrapper;
  final List<RouteConfig> children;
  final bool hasConstConstructor;
  final Set<String> imports;
  final String? parentClassName;

  // ========== v2 parameters below =========
  final List<PathParamConfig> pathParams;
  final bool initial;
  final bool? fullMatch;
  final bool? customRouteOpaque;
  final bool? customRouteBarrierDismissible;
  final String? customRouteBarrierLabel;
  final int? customRouteBarrierColor;
  final ResolvedType? pageType;
  final ResolvedType? transitionBuilder;
  final ResolvedType? customRouteBuilder;
  final String? redirectTo;
  final bool? hasWrappedRoute;
  final int? reverseDurationInMilliseconds;
  final int? durationInMilliseconds;
  final int routeType;
  final List<ResolvedType> guards;
  final String? cupertinoNavTitle;
  final String? replacementInRouteName;
  final RouterConfig? childRouterConfig;
  final bool usesPathAsKey;
  final List<MetaEntry> meta;
  final bool? deferredLoading;

  const RouteConfig({
    this.name,
    required this.pathName,
    this.pathParams = const [],
    this.initial = false,
    this.fullscreenDialog = false,
    this.fullMatch,
    this.customRouteOpaque,
    this.customRouteBarrierDismissible,
    this.customRouteBarrierLabel,
    this.maintainState = true,
    this.pageType,
    required this.className,
    required this.classImport,
    this.parameters = const [],
    this.transitionBuilder,
    this.customRouteBuilder,
    this.redirectTo,
    this.hasWrappedRoute,
    this.durationInMilliseconds,
    this.reverseDurationInMilliseconds,
    this.returnType,
    this.routeType = RouteType.material,
    this.guards = const [],
    this.cupertinoNavTitle,
    this.replacementInRouteName,
    this.childRouterConfig,
    this.hasConstConstructor = false,
    this.usesPathAsKey = false,
    this.customRouteBarrierColor,
    this.meta = const [],
    this.deferredLoading,
    this.hasWrapper = false,
    this.children = const [],
    this.imports = const {},
    this.parentClassName,
  });

  Code registerRoute() {
    return const Code('');
  }

  RouteConfig copyWith({
    String? name,
    String? pathName,
    List<PathParamConfig>? pathParams,
    bool? initial,
    bool? fullscreenDialog,
    bool? fullMatch,
    bool? customRouteOpaque,
    bool? customRouteBarrierDismissible,
    int? customRouteBarrierColor,
    String? customRouteBarrierLabel,
    bool? maintainState,
    ResolvedType? pageType,
    String? className,
    String? classImport,
    ResolvedType? returnType,
    List<ParamConfig>? parameters,
    ResolvedType? transitionBuilder,
    ResolvedType? customRouteBuilder,
    String? redirectTo,
    bool? usesTabsRouter,
    int? reverseDurationInMilliseconds,
    int? durationInMilliseconds,
    int? routeType,
    List<ResolvedType>? guards,
    String? cupertinoNavTitle,
    String? replacementInRouteName,
    RouterConfig? childRouterConfig,
    bool? hasConstConstructor,
    bool? usesPathAsKey,
    List<MetaEntry>? meta,
    bool? deferredLoading,
    List<RouteConfig>? children,
  }) {
    return RouteConfig(
      children: children ?? this.children,
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      pathParams: pathParams ?? this.pathParams,
      initial: initial ?? this.initial,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      fullMatch: fullMatch ?? this.fullMatch,
      customRouteOpaque: customRouteOpaque ?? this.customRouteOpaque,
      customRouteBarrierDismissible:
          customRouteBarrierDismissible ?? this.customRouteBarrierDismissible,
      customRouteBarrierLabel:
          customRouteBarrierLabel ?? this.customRouteBarrierLabel,
      maintainState: maintainState ?? this.maintainState,
      pageType: pageType ?? this.pageType,
      className: className ?? this.className,
      classImport: classImport ?? this.classImport,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
      customRouteBuilder: customRouteBuilder ?? this.customRouteBuilder,
      redirectTo: redirectTo ?? this.redirectTo,
      hasWrappedRoute: usesTabsRouter ?? hasWrappedRoute,
      reverseDurationInMilliseconds:
          reverseDurationInMilliseconds ?? this.reverseDurationInMilliseconds,
      durationInMilliseconds:
          durationInMilliseconds ?? this.durationInMilliseconds,
      routeType: routeType ?? this.routeType,
      guards: guards ?? this.guards,
      cupertinoNavTitle: cupertinoNavTitle ?? this.cupertinoNavTitle,
      replacementInRouteName:
          replacementInRouteName ?? this.replacementInRouteName,
      childRouterConfig: childRouterConfig ?? this.childRouterConfig,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      usesPathAsKey: usesPathAsKey ?? this.usesPathAsKey,
      meta: meta ?? this.meta,
      deferredLoading: deferredLoading ?? this.deferredLoading,
      customRouteBarrierColor:
          customRouteBarrierColor ?? this.customRouteBarrierColor,
    );
  }

  Code get joinedConstructerParams {
    final constructorParams = _extractViewConstructerParametersNames();

    final constructor = Block.of([
      Code("${hasConstConstructor == true ? 'const' : ''}  "),
      Reference(className, className).code,
      Code(
          "(${constructorParams.join(',')})${(hasWrapper) ? ".wrappedRoute(context)" : ""}")
    ]);
    return constructor;
  }

  Code registerRouteBloc({
    required String routeType,
    String? routeTypeImport,
    Code? extra,
    bool usePageBuilder = false,
  }) {
    return Block.of([
      const Code('return '),
      Reference(routeType, routeTypeImport).code,
      usePageBuilder
          ? Code(
              '<$processedReturnType>(pageBuilder: (context, animation, secondaryAnimation) => ')
          : Code('<$processedReturnType>(builder: (context) => '),
      joinedConstructerParams,
      const Code(', settings: data,'),
      if (extra != null) extra,
      if (fullscreenDialog) const Code('fullscreenDialog:true,'),
      if (!maintainState) const Code('maintainState:false,'),
      const Code(');')
    ]);
  }

  Iterable<String> _extractViewConstructerParametersNames() {
    return parameters.map<String>((param) {
      String getterName;
      if (param.isPathParam) {
        getterName =
            "data.pathParams['${param.paramName}'].${param.getterName}(${param.defaultValueCode != null ? '${param.defaultValueCode}' : ''})";
      } else if (param.isQueryParam) {
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
    });
  }

  bool get isProcessedReturnTypeDynamic => processedReturnType == 'dynamic';

  String get processedReturnType {
    final returnTypeContainsBiggerOperatorWithOneOfRouteNames = returnType !=
            null &&
        returnType!.name.contains('<') &&
        returnType!.name.contains(
            RegExp('CustomRoute|MaterialRoute|CupertinoRoute|AdaptiveRoute'));

    if (returnTypeContainsBiggerOperatorWithOneOfRouteNames) {
      final afterRemovingArrowHeads = returnType!.name.substring(
          returnType!.name.indexOf('<') + 1, returnType!.name.lastIndexOf('>'));

      return afterRemovingArrowHeads;
    } else {
      return returnType?.name ?? 'dynamic';
    }
  }

  String get argumentsHolderClassName {
    return '${className}Arguments';
  }

  String get templateName {
    final routeName = name ?? "${toLowerCamelCase(className)}Route";
    return pathName.contains(":") ? '_$routeName' : routeName;
  }

  bool get isParent => childRouterConfig != null;

  List<ParamConfig> get argParams {
    return parameters.where((p) => !p.isPathParam && !p.isQueryParam).toList();
  }

  List<ParamConfig> get pathQueryParams {
    return parameters
        .where(
            (p) => (p.isPathParam || p.isQueryParam) && !p.isInheritedPathParam)
        .toList();
  }

  Iterable<ParamConfig> get requiredParams =>
      parameters.where((p) => p.isPositional && !p.isOptional);

  Iterable<ParamConfig> get positionalParams =>
      parameters.where((p) => p.isPositional);

  Iterable<ParamConfig> get namedParams => parameters.where((p) => p.isNamed);

  String get routeName {
    String? nameToUse;
    if (name != null) {
      nameToUse = name;
    } else if (replacementInRouteName != null &&
        replacementInRouteName!.split(',').length == 2) {
      var parts = replacementInRouteName!.split(',');
      nameToUse = className.replaceAll(RegExp(parts[0]), parts[1]);
    } else {
      nameToUse = "${className}Route";
    }
    return capitalize(nameToUse!);
  }

  String get pageTypeName {
    switch (routeType) {
      case RouteType.cupertino:
        return 'CupertinoPageX';
      case RouteType.custom:
        return 'CustomPage';
      case RouteType.adaptive:
        return 'AdaptivePage';
      default:
        return 'MaterialPageX';
    }
  }

  bool get hasUnparsableRequiredArgs => parameters.any((p) =>
      (p.isRequired || p.isPositional) && !p.isPathParam && !p.isQueryParam);
}

class MetaEntry<T> {
  MetaEntry({
    required this.type,
    required this.key,
    required this.value,
  });

  final String type;
  final T value;
  final String key;
}

class RouteType {
  static const int material = 0;
  static const int cupertino = 1;
  static const int adaptive = 2;
  static const int custom = 3;
  static const int redirect = 4;
}
