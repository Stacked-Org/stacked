import '../models/custom_transition_builder.dart';
import 'route_config.dart';

class CustomRouteConfig extends RouteConfig {
  final int? durationInMilliseconds;
  final int? reverseDurationInMilliseconds;
  final bool customRouteOpaque;
  final bool customRouteBarrierDismissible;
  final CustomTransitionBuilder? transitionBuilder;
  const CustomRouteConfig(
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
      this.durationInMilliseconds,
      this.reverseDurationInMilliseconds,
      this.customRouteOpaque = true,
      this.customRouteBarrierDismissible = false,
      this.transitionBuilder,
      super.parentClassName});

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(
        'return PageRouteBuilder<$processedReturnType>(pageBuilder: (context, animation, secondaryAnimation) => $joinedConstructerParams, settings: data,');

    if (!customRouteOpaque)
      stringBuffer.write('opaque:${customRouteOpaque.toString()},');

    if (customRouteBarrierDismissible) {
      stringBuffer.write(
          'barrierDismissible:${customRouteBarrierDismissible.toString()},');
    }
    if (transitionBuilder != null) {
      stringBuffer.write(
          'transitionsBuilder: data.transition ?? ${transitionBuilder!.name},');
    }
    if (transitionBuilder == null) {
      stringBuffer.write('''transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          },''');
    }
    if (durationInMilliseconds != null) {
      stringBuffer.write(
          'transitionDuration: const Duration(milliseconds: ${durationInMilliseconds}),');
    }
    if (reverseDurationInMilliseconds != null) {
      stringBuffer.write(
          'reverseTransitionDuration: const Duration(milliseconds: ${reverseDurationInMilliseconds}),');
    }
    stringBuffer.write(super.registerRoutes());
    return stringBuffer.toString();
  }
}
