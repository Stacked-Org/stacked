import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';

import '../../../../import_resolver.dart';
import '../models/custom_transition_builder.dart';
import '../models/route_parameter_config.dart';
import 'adaptive_route_config.dart';
import 'cupertino_route_config.dart';
import 'custom_route_config.dart';
import 'material_route_config.dart';
import 'route_config.dart';

class RouteConfigFactory {
  final bool hasWrapper;
  final String? returnType;
  final String pathName;
  final String name;
  final MapEntry<String, String> className;
  final bool maintainState;
  final bool fullscreenDialog;
  final bool hasConstConstructor;
  final String? parentClassName;
  final List<RouteParamConfig> parameters;
  const RouteConfigFactory({
    required this.hasWrapper,
    this.returnType,
    required this.pathName,
    required this.name,
    required this.className,
    required this.maintainState,
    required this.fullscreenDialog,
    required this.hasConstConstructor,
    required this.parameters,
    required this.parentClassName,
  });

  RouteConfig fromResolver(
      ConstantReader stackedRoute, ImportResolver importResolver) {
    if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CupertinoRoute))) {
      return CupertinoRouteConfig(
        className: className,
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
        .instanceOf(TypeChecker.fromRuntime(AdaptiveRoute))) {
      return AdaptiveRouteConfig(
        className: className,
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
    } else if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CustomRoute))) {
      final function = stackedRoute
          .peek('transitionsBuilder')
          ?.objectValue
          .toFunctionValue();

      CustomTransitionBuilder? customTransitionBuilder;
      if (function != null) {
        final displayName = function.displayName.replaceFirst(RegExp('^_'), '');
        final functionName = function.isStatic
            ? '${function.enclosingElement2.displayName}.$displayName'
            : displayName;

        String? import;
        if (function.enclosingElement2.name != 'TransitionsBuilders') {
          import = function.source.uri.toString();
        }
        customTransitionBuilder = CustomTransitionBuilder(functionName, import);
      }

      var customRouteConfig = CustomRouteConfig(
        transitionBuilder: customTransitionBuilder,
        className: className,
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
