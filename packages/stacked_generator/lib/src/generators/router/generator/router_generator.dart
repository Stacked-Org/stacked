import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/router/generator/routes_class_builder.dart';

import '../router_config/router_config.dart';

class RouterGenerator implements BaseGenerator {
  final RouterConfig _rootRouterConfig;

  RouterGenerator(this._rootRouterConfig);
  @override
  String generate() {
    final routesClassBuilder =
        RoutesClassBuilder(routes: _rootRouterConfig.routes).buildRoutesClass();

    final library = Library((b) => b
      ..body.addAll([
        routesClassBuilder,
      ]));

    final emitter = DartEmitter.scoped();
    return DartFormatter().format('${library.accept(emitter)}');
  }
}
