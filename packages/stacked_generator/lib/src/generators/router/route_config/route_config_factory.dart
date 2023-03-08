import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/src/generators/router_common/models/importable_type.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';

import '../../router_common/models/route_parameter_config.dart';
import 'adaptive_route_config.dart';
import 'cupertino_route_config.dart';
import 'custom_route_config.dart';
import 'material_route_config.dart';

class RouteConfigFactory {
  final bool hasWrapper;
  final ResolvedType? returnType;
  final String pathName;
  final String name;
  // TODO (Generate Routes): This might be a breaking change, keep an eye out for it
  final String className;
  final String classImport;
  final bool maintainState;
  final bool fullscreenDialog;
  final bool hasConstConstructor;
  final String? parentClassName;
  final List<ParamConfig> parameters;
  const RouteConfigFactory({
    required this.hasWrapper,
    this.returnType,
    required this.pathName,
    required this.name,
    required this.className,
    required this.classImport,
    required this.maintainState,
    required this.fullscreenDialog,
    required this.hasConstConstructor,
    required this.parameters,
    required this.parentClassName,
  });

  RouteConfig fromResolver(ConstantReader stackedRoute) {
    if (stackedRoute
        .instanceOf(const TypeChecker.fromRuntime(CupertinoRoute))) {
      return CupertinoRouteConfig(
        className: className,
        classImport: classImport,
        name: name,
        pathName: pathName,
        fullscreenDialog: fullscreenDialog,
        hasConstConstructor: hasConstConstructor,
        hasWrapper: hasWrapper,
        maintainState: maintainState,
        parameters: parameters,
        returnType: returnType,
        cupertinoNavTitle: stackedRoute.peek('title')?.stringValue,
        parentClassName: parentClassName,
      );
    } else if (stackedRoute
        .instanceOf(const TypeChecker.fromRuntime(AdaptiveRoute))) {
      return AdaptiveRouteConfig(
        className: className,
        classImport: classImport,
        name: name,
        pathName: pathName,
        fullscreenDialog: fullscreenDialog,
        hasConstConstructor: hasConstConstructor,
        hasWrapper: hasWrapper,
        maintainState: maintainState,
        parameters: parameters,
        returnType: returnType,
        cupertinoNavTitle: stackedRoute.peek('cupertinoPageTitle')?.stringValue,
        parentClassName: parentClassName,
      );
    } else if (stackedRoute
        .instanceOf(const TypeChecker.fromRuntime(CustomRoute))) {
      final function = stackedRoute
          .peek('transitionsBuilder')
          ?.objectValue
          .toFunctionValue();

      ResolvedType? customTransitionBuilder;
      if (function != null) {
        final displayName = function.displayName.replaceFirst(RegExp('^_'), '');
        final functionName = function.isStatic
            ? '${function.enclosingElement.displayName}.$displayName'
            : displayName;

        customTransitionBuilder = ResolvedType(
          name: functionName,
          import: function.source.uri.toString(),
        );
      }

      var customRouteConfig = CustomRouteConfig(
        transitionBuilder: customTransitionBuilder,
        className: className,
        classImport: classImport,
        name: name,
        pathName: pathName,
        fullscreenDialog: fullscreenDialog,
        hasConstConstructor: hasConstConstructor,
        hasWrapper: hasWrapper,
        maintainState: maintainState,
        parameters: parameters,
        returnType: returnType,
        durationInMilliseconds:
            stackedRoute.peek('durationInMilliseconds')?.intValue,
        reverseDurationInMilliseconds:
            stackedRoute.peek('reverseDurationInMilliseconds')?.intValue,
        customRouteOpaque: stackedRoute.peek('opaque')?.boolValue ?? true,
        customRouteBarrierDismissible:
            stackedRoute.peek('barrierDismissible')?.boolValue ?? false,
        parentClassName: parentClassName,
      );

      return customRouteConfig;
    } else {
      return MaterialRouteConfig(
        className: className,
        classImport: classImport,
        name: name,
        pathName: pathName,
        fullscreenDialog: fullscreenDialog,
        hasConstConstructor: hasConstConstructor,
        hasWrapper: hasWrapper,
        maintainState: maintainState,
        parameters: parameters,
        returnType: returnType,
        parentClassName: parentClassName,
      );
    }
  }
}
