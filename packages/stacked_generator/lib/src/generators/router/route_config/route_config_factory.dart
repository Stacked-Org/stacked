import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';

import '../../../../import_resolver.dart';
import '../models/custom_transition_builder.dart';
import 'adaptive_route_config.dart';
import 'cupertino_route_config.dart';
import 'custom_route_config.dart';
import 'material_route_config.dart';
import 'route_config.dart';

class RouteConfigFactory {
  final RouteConfig routeConfig;

  const RouteConfigFactory(this.routeConfig);

  RouteConfig fromResolver(
      ConstantReader stackedRoute, ImportResolver importResolver) {
    if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CupertinoRoute))) {
      return CupertinoRouteConfig(
          className: routeConfig.className,
          name: routeConfig.name,
          pathName: routeConfig.pathName,
          fullscreenDialog: routeConfig.fullscreenDialog,
          guards: routeConfig.guards,
          hasConstConstructor: routeConfig.hasConstConstructor,
          hasWrapper: routeConfig.hasWrapper,
          imports: routeConfig.imports,
          maintainState: routeConfig.maintainState,
          parameters: routeConfig.parameters,
          returnType: routeConfig.returnType,
          children: routeConfig.children,
          cupertinoNavTitle: stackedRoute.peek('title')?.stringValue);
    } else if (stackedRoute
        .instanceOf(TypeChecker.fromRuntime(AdaptiveRoute))) {
      return AdaptiveRouteConfig(
          className: routeConfig.className,
          name: routeConfig.name,
          pathName: routeConfig.pathName,
          fullscreenDialog: routeConfig.fullscreenDialog,
          guards: routeConfig.guards,
          hasConstConstructor: routeConfig.hasConstConstructor,
          hasWrapper: routeConfig.hasWrapper,
          imports: routeConfig.imports,
          maintainState: routeConfig.maintainState,
          parameters: routeConfig.parameters,
          returnType: routeConfig.returnType,
          children: routeConfig.children,
          cupertinoNavTitle:
              stackedRoute.peek('cupertinoPageTitle')?.stringValue);
    } else if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CustomRoute))) {
      var customRouteConfig = CustomRouteConfig(
        className: routeConfig.className,
        name: routeConfig.name,
        pathName: routeConfig.pathName,
        fullscreenDialog: routeConfig.fullscreenDialog,
        guards: routeConfig.guards,
        hasConstConstructor: routeConfig.hasConstConstructor,
        hasWrapper: routeConfig.hasWrapper,
        imports: routeConfig.imports,
        maintainState: routeConfig.maintainState,
        parameters: routeConfig.parameters,
        returnType: routeConfig.returnType,
        children: routeConfig.children,
        durationInMilliseconds:
            stackedRoute.peek('durationInMilliseconds')?.intValue,
        reverseDurationInMilliseconds:
            stackedRoute.peek('reverseDurationInMilliseconds')?.intValue,
        customRouteOpaque: stackedRoute.peek('opaque')?.boolValue ?? true,
        customRouteBarrierDismissible:
            stackedRoute.peek('barrierDismissible')?.boolValue ?? false,
      );
      final function = stackedRoute
          .peek('transitionsBuilder')
          ?.objectValue
          .toFunctionValue();
      if (function != null) {
        final displayName = function.displayName.replaceFirst(RegExp('^_'), '');
        final functionName = function.isStatic
            ? '${function.enclosingElement.displayName}.$displayName'
            : displayName;

        var import;
        if (function.enclosingElement.name != 'TransitionsBuilders') {
          import = importResolver.resolve(function);
        }
        customRouteConfig = customRouteConfig.copyWith(
            transitionBuilder: CustomTransitionBuilder(functionName, import));
      }

      return customRouteConfig;
    } else {
      return MaterialRouteConfig(
          className: routeConfig.className,
          name: routeConfig.name,
          pathName: routeConfig.pathName,
          fullscreenDialog: routeConfig.fullscreenDialog,
          guards: routeConfig.guards,
          hasConstConstructor: routeConfig.hasConstConstructor,
          hasWrapper: routeConfig.hasWrapper,
          imports: routeConfig.imports,
          maintainState: routeConfig.maintainState,
          parameters: routeConfig.parameters,
          returnType: routeConfig.returnType,
          children: routeConfig.children);
    }
  }
}
