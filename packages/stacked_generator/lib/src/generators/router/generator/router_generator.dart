import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/extensions/routes_extension.dart';
import 'package:stacked_generator/src/generators/router/generator/routes_class/routes_class_builder.dart';

import '../router_config/router_config.dart';
import 'arguments_class/arguments_class_builder.dart';
import 'navigate_extension_class/navigate_extension_class_builder.dart';
import 'router_class/router_class_builder.dart';

class RouterGenerator implements BaseGenerator {
  final RouterConfig _rootRouterConfig;

  RouterGenerator(this._rootRouterConfig);
  List<Spec> classes = [];

  @override
  String generate() {
    if (_rootRouterConfig.routes.isEmpty) return '';
    _rootRouterConfig.traverseRoutes(_generateClasses);
    final navigationExtensionClassBuilder = NavigateExtensionClassBuilder(
      routes: _rootRouterConfig.routesIncludingTheirChildren,
    ).build();

    final library = Library(
      (b) => b
        ..directives.add(
          Directive.import('package:flutter/material.dart'),
        )
        ..body.addAll([...classes, navigationExtensionClassBuilder]),
    );

    final emitter =
        DartEmitter.scoped(orderDirectives: true, useNullSafetySyntax: true);

    return DartFormatter().format('${library.accept(emitter)}');
  }

  void _generateClasses(RouterConfig routerConfig) {
    if (routerConfig.routes.isEmpty) return;

    final routesClassBuilder = RoutesClassBuilder(
            routes: routerConfig.routes,
            routesClassName: routerConfig.routesClassName)
        .buildRoutesClass();

    final routerClassBuilder = RouterClassBuilder(
      routesClassName: routerConfig.routesClassName,
      routes: routerConfig.routes,
      routerClassName: routerConfig.routerClassName,
    ).buildRouterClass();

    final argumentsClassBuilder = ArgumentsClassBuilder(
      routes: routerConfig.routes,
    ).buildViewsArguments();

    classes.addAll([
      routesClassBuilder,
      routerClassBuilder,
      ...argumentsClassBuilder,
    ]);
  }
}
