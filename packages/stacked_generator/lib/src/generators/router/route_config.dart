import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/utils.dart';

/// holds the extracted route configs
/// to be used in [RouterClassGenerator]

class RouteConfig {
  List<String> imports = [];
  late String name;
  late String pathName;
  bool? initial;
  bool? fullscreenDialog;
  bool? customRouteOpaque;
  bool? customRouteBarrierDismissible;
  bool? maintainState;
  String? className;
  String? returnType;
  List<RouteParamConfig>? parameters;
  CustomTransitionBuilder? transitionBuilder;
  int? durationInMilliseconds;
  int? reverseDurationInMilliseconds;
  int routeType = RouteType.material;
  List<RouteGuardConfig> guards = [];
  String? cupertinoNavTitle;
  bool? hasWrapper;
  RouterConfig? routerConfig;

  bool? hasConstConstructor;

  String get argumentsHolderClassName {
    return '${className}Arguments';
  }

  String? get templateName {
    return pathName.contains(":") ? '_$name' : name;
  }

  List<RouteParamConfig> get notQueryAndNotPath {
    return parameters?.where((p) {
          throwIf(p.isPathParam == null || p.isQueryParam == null,
              ExceptionMessages.isPathParamAndIsQueryParamShouldNotBeNull);
          return !p.isPathParam! && !p.isQueryParam!;
        }).toList() ??
        [];
  }
}

class RouteType {
  static const int material = 0;
  static const int cupertino = 1;
  static const int adaptive = 2;
  static const int custom = 3;
}
