import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';
import 'package:stacked_generator/utils.dart';

import '../../router_common/models/importable_type.dart';
import '../../router_common/models/route_config.dart';
import '../../router_common/models/route_parameter_config.dart';
import '../../router_common/models/router_config.dart';
import '../../router_common/resolvers/route_parameter_resolver.dart';
import '../../router_common/resolvers/type_resolver.dart';

const TypeChecker autoRouteChecker = TypeChecker.fromUrl(
  'package:stacked_core/src/code_generation/stacked_app.dart#StackedApp',
);

const TypeChecker stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

const validMetaValues = [
  'String',
  'bool',
  'int',
  'double',
];

// extracts route configs from class fields and their meta data
class RouteConfigResolver {
  final String? routeNamePrefix;
  final RouterConfig _routerConfig;
  final TypeResolver _typeResolver;

  RouteConfigResolver(
    this.routeNamePrefix,
    this._routerConfig,
    this._typeResolver,
  );

  // TODO (Refactor): This entire function should be refactored, tested and
  // recorded for a video
  RouteConfig resolve(
    ConstantReader stackedRoute,
    List<PathParamConfig> inheritedPathParams, {
    RouterConfig? parentRouterConfig,
  }) {
    final page = stackedRoute.peek('page')?.typeValue;
    var path = stackedRoute.peek('path')?.stringValue;
    var isDeferred = stackedRoute.peek('deferredLoading')?.boolValue ??
        _routerConfig.deferredLoading;

    if (page == null) {
      var redirectTo = stackedRoute.peek('redirectTo')?.stringValue;
      throwIf(
        redirectTo == null,
        'Route must have either a page or a redirect destination',
      );

      return RouteConfig(
        pathName: path!,
        redirectTo: redirectTo,
        className: '',
        classImport: '',
        fullMatch: stackedRoute.peek('fullMatch')?.boolValue ?? true,
        routeType: RouteType.redirect,
        deferredLoading: isDeferred,
        parentRouterConfig: parentRouterConfig,
      );
    }

    throwIf(
      page.element is! ClassElement,
      '${page.getDisplayString(withNullability: false)} is not a class element',
      element: page.element,
    );

    final classElement = page.element as ClassElement;
    final import = _typeResolver.resolveImport(classElement);
    final hasWrappedRoute = classElement.allSupertypes.any((e) =>
        e.getDisplayString(withNullability: false) == 'AutoRouteWrapper');
    var pageType = _typeResolver.resolveType(page);
    var className = page.getDisplayString(withNullability: false);

    if (path == null) {
      var prefix = _routerConfig.parent != null ? '' : '/';
      if (stackedRoute.peek('initial')?.boolValue == true) {
        path = prefix;
      } else {
        path = '$prefix${toKababCase(className)}';
      }
    }
    throwIf(
      path.startsWith('/') && _routerConfig.parent != null,
      'Child [$path] can not start with a forward slash',
    );

    String? pathName = stackedRoute.peek('path')?.stringValue;
    if (pathName == null) {
      if (stackedRoute.peek('initial')?.boolValue == true) {
        pathName = '/';
      } else {
        pathName = '$routeNamePrefix${className.toKababCase}';
      }
    }
    var pathParams = RouteParameterResolver.extractPathParams(path);

    final fullscreenDialog = stackedRoute.peek('fullscreenDialog')?.boolValue;
    final maintainState = stackedRoute.peek('maintainState')?.boolValue;
    final fullMatch = stackedRoute.peek('fullMatch')?.boolValue;
    final initial = stackedRoute.peek('initial')?.boolValue ?? false;
    final usesPathAsKey =
        stackedRoute.peek('usesPathAsKey')?.boolValue ?? false;

    var guards = <ResolvedType>[];
    stackedRoute.peek('guards')?.listValue.map((g) => g.toTypeValue()).forEach(
      (guard) {
        guards.add(_typeResolver.resolveType(guard!));
      },
    );

    var dartType = stackedRoute.objectValue.type;
    var returnType = ResolvedType(name: dartType.toString());
    if (dartType is InterfaceType) {
      returnType = _typeResolver.resolveType(dartType.typeArguments.first);
    }

    int routeType = RouteType.material;
    String? cupertinoNavTitle;
    int? durationInMilliseconds;
    int? reverseDurationInMilliseconds;
    bool? customRouteOpaque;
    bool? customRouteBarrierDismissible;
    String? customRouteBarrierLabel;
    ResolvedType? customRouteBuilder;
    ResolvedType? transitionBuilder;
    int? customRouteBarrierColor;
    if (stackedRoute.instanceOf(const TypeChecker.fromRuntime(MaterialRoute))) {
      routeType = RouteType.material;
    } else if (stackedRoute
        .instanceOf(const TypeChecker.fromRuntime(CupertinoRoute))) {
      routeType = RouteType.cupertino;
      cupertinoNavTitle = stackedRoute.peek('title')?.stringValue;
    } else if (stackedRoute
        .instanceOf(const TypeChecker.fromRuntime(AdaptiveRoute))) {
      routeType = RouteType.adaptive;
      cupertinoNavTitle = stackedRoute.peek('cupertinoPageTitle')?.stringValue;
      customRouteOpaque = stackedRoute.peek('opaque')?.boolValue;
    } else if (stackedRoute
        .instanceOf(const TypeChecker.fromRuntime(CustomRoute))) {
      routeType = RouteType.custom;
      durationInMilliseconds =
          stackedRoute.peek('durationInMilliseconds')?.intValue;
      reverseDurationInMilliseconds =
          stackedRoute.peek('reverseDurationInMilliseconds')?.intValue;
      customRouteOpaque = stackedRoute.peek('opaque')?.boolValue;
      customRouteBarrierDismissible =
          stackedRoute.peek('barrierDismissible')?.boolValue;
      customRouteBarrierLabel = stackedRoute.peek('barrierLabel')?.stringValue;
      final function = stackedRoute
          .peek('transitionsBuilder')
          ?.objectValue
          .toFunctionValue();
      if (function != null) {
        transitionBuilder = _typeResolver.resolveFunctionType(function);
      }
      final builderFunction = stackedRoute
          .peek('customRouteBuilder')
          ?.objectValue
          .toFunctionValue();
      if (builderFunction != null) {
        customRouteBuilder = _typeResolver.resolveFunctionType(builderFunction);
      }
      customRouteBarrierColor = stackedRoute.peek('barrierColor')?.intValue;
    } else if (_routerConfig.parentRouteConfig != null) {
      var globConfig = _routerConfig.parentRouteConfig!;
      routeType = globConfig.routeType;
      if (globConfig.routeType == RouteType.custom) {
        transitionBuilder = globConfig.transitionBuilder;
        durationInMilliseconds = globConfig.durationInMilliseconds;
        customRouteBarrierDismissible =
            globConfig.customRouteBarrierDismissible;
        customRouteOpaque = globConfig.customRouteOpaque;
        reverseDurationInMilliseconds =
            globConfig.reverseDurationInMilliseconds;
        customRouteBuilder = globConfig.customRouteBuilder;
      }
    }

    final meta = <MetaEntry>[];
    for (final entry in stackedRoute
        .read('meta')
        .mapValue
        .entries
        .where((e) => e.value?.type != null)) {
      final valueType =
          entry.value!.type!.getDisplayString(withNullability: false);
      throwIf(!validMetaValues.contains(valueType),
          'Meta value type $valueType is not supported!\nSupported types are $validMetaValues');
      switch (valueType) {
        case 'bool':
          {
            meta.add(MetaEntry<bool>(
              key: entry.key!.toStringValue()!,
              type: valueType,
              value: entry.value!.toBoolValue()!,
            ));
            break;
          }
        case 'String':
          {
            meta.add(MetaEntry<String>(
              key: entry.key!.toStringValue()!,
              type: valueType,
              value: entry.value!.toStringValue()!,
            ));

            break;
          }
        case 'int':
          {
            meta.add(MetaEntry<int>(
              key: entry.key!.toStringValue()!,
              type: valueType,
              value: entry.value!.toIntValue()!,
            ));
            break;
          }
        case 'double':
          {
            meta.add(MetaEntry<double>(
              key: entry.key!.toStringValue()!,
              type: valueType,
              value: entry.value!.toDoubleValue()!,
            ));
            break;
          }
      }
    }

    var name =
        stackedRoute.peek('name')?.stringValue ?? className.toLowerCamelCase;

    var replacementInRouteName = _routerConfig.replaceInRouteName;

    final constructor = classElement.unnamedConstructor;
    throwIf(
      constructor == null,
      'Route widgets must have an unnamed constructor',
    );
    var hasConstConstructor = false;
    var params = constructor!.parameters;
    var parameters = <ParamConfig>[];
    if (params.isNotEmpty == true) {
      if (constructor.isConst &&
          params.length == 1 &&
          params.first.type.getDisplayString(withNullability: false) == 'Key') {
        hasConstConstructor = true;
      } else {
        final paramResolver = RouteParameterResolver(_typeResolver);
        for (ParameterElement p in constructor.parameters) {
          parameters.add(paramResolver.resolve(
            p,
            pathParams: pathParams,
            inheritedPathParams: inheritedPathParams,
          ));
        }
      }
    }

    var pathParameters = parameters.where((element) => element.isPathParam);

    if (parameters.any((p) => p.isPathParam || p.isQueryParam)) {
      var unParsableRequiredArgs = parameters.where((p) =>
          (p.isRequired || p.isPositional) &&
          !p.isPathParam &&
          !p.isQueryParam);
      if (unParsableRequiredArgs.isNotEmpty) {
        // ignore: avoid_print
        print(
            '\nWARNING => Because [$className] has required parameters ${unParsableRequiredArgs.map((e) => e.paramName)} '
            'that can not be parsed from path,\n@PathParam() and @QueryParam() annotations will be ignored.\n');
      }
    }

    if (pathParameters.isNotEmpty) {
      for (var pParam in pathParameters) {
        throwIf(!validPathParamTypes.contains(pParam.type.name),
            "Parameter [${pParam.name}] must be of a type that can be parsed from a [String] because it will also obtain it's value from a path\nvalid types: $validPathParamTypes",
            element: pParam.element);
      }
    }

    return RouteConfig(
      parentClassName: parentRouterConfig?.routerClassName,
      parentRouterConfig: parentRouterConfig,
      parameters: parameters,
      hasWrapper: classElement.allSupertypes
          .map<String>((el) => toDisplayString(el))
          .contains('StackedRouteWrapper'),
      returnType: returnType,
      pathName: pathName,
      name: name,
      maintainState: maintainState ?? true,
      className: className,
      classImport: import ?? '',
      fullscreenDialog: fullscreenDialog ?? false,
      hasConstConstructor: hasConstConstructor,
      initial: initial,
      pathParams: pathParams,
      routeType: routeType,
      hasWrappedRoute: hasWrappedRoute,
      transitionBuilder: transitionBuilder,
      customRouteBuilder: customRouteBuilder,
      customRouteBarrierDismissible: customRouteBarrierDismissible,
      customRouteOpaque: customRouteOpaque,
      cupertinoNavTitle: cupertinoNavTitle,
      durationInMilliseconds: durationInMilliseconds,
      reverseDurationInMilliseconds: reverseDurationInMilliseconds,
      replacementInRouteName: replacementInRouteName,
      pageType: pageType,
      guards: guards,
      customRouteBarrierLabel: customRouteBarrierLabel,
      fullMatch: fullMatch,
      usesPathAsKey: usesPathAsKey,
      meta: meta,
      deferredLoading: isDeferred,
      customRouteBarrierColor: customRouteBarrierColor,
    );
  }
}
