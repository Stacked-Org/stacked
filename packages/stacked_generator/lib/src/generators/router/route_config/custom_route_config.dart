import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';

class CustomRouteConfig extends RouteConfig {
  const CustomRouteConfig(
      {required super.name,
      required super.pathName,
      required super.className,
      required super.classImport,
      super.fullscreenDialog,
      super.maintainState,
      super.returnType,
      super.parameters,
      super.hasWrapper,
      super.hasConstConstructor,
      super.children,
      super.imports,
      super.durationInMilliseconds,
      super.reverseDurationInMilliseconds,
      super.customRouteOpaque = true,
      super.customRouteBarrierDismissible = false,
      super.transitionBuilder,
      super.parentClassName});

  @override
  Code registerRoute() {
    return super.registerRouteBloc(
      routeType: 'PageRouteBuilder',
      usePageBuilder: true,
      extra: Block.of([
        if (!(customRouteOpaque ?? false))
          Code('opaque:${customRouteOpaque.toString()},'),
        if (customRouteBarrierDismissible ?? false)
          Code(
              'barrierDismissible:${customRouteBarrierDismissible.toString()},'),
        if (transitionBuilder != null) ...[
          const Code('transitionsBuilder: data.transition ?? '),
          Reference(transitionBuilder!.name, transitionBuilder!.import).code,
          const Code(',')
        ],
        if (transitionBuilder == null)
          const Code('''transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          },'''),
        if (durationInMilliseconds != null)
          Code(
              'transitionDuration: const Duration(milliseconds: $durationInMilliseconds),'),
        if (reverseDurationInMilliseconds != null)
          Code(
              'reverseTransitionDuration: const Duration(milliseconds: $reverseDurationInMilliseconds),'),
      ]),
    );
  }
}
