import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/navigate_extension_class/navigate_extension_class_builder_helper.dart';

import '../../../router_common/models/route_config.dart';

class NavigateExtensionClassBuilder with NavigateExtensionClassBuilderHelper {
  final List<RouteConfig> routes;

  const NavigateExtensionClassBuilder({
    required this.routes,
  });

  Extension build(DartEmitter emitter) {
    return Extension(
      (b) => b
        ..name = 'NavigatorStateExtension'
        ..on = const Reference(
          'NavigationService',
          'package:stacked_services/stacked_services.dart',
        )
        ..methods.addAll(buildNavigateToExtensionMethods(routes, emitter)),
    );
  }
}
