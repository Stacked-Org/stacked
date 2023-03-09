import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:stacked_generator/src/generators/extensions/routes_extension.dart';
import 'package:stacked_generator/src/generators/router/generator/arguments_class/arguments_class_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/navigate_extension_class/navigate_extension_class_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/route_allocator.dart';
import 'package:stacked_generator/src/generators/router/generator/router_class/router_class_builder.dart';
import 'package:stacked_generator/src/generators/router/generator/routes_class/routes_class_builder.dart';
import 'package:stacked_generator/utils.dart';

import '../../router_common/models/importable_type.dart';
import '../../router_common/models/route_config.dart';
import '../../router_common/models/router_config.dart';
import 'deferred_pages_allocator.dart';
import 'root_router_builder.dart';
import 'route_info_builder.dart';

const stackedImport = 'package:stacked/stacked.dart';
const materialImport = 'package:flutter/material.dart';
const foundationImport = 'package:flutter/foundation.dart';

const Reference stringRefer = Reference('String');
const Reference pageRouteType = Reference('PageRouteInfo', stackedImport);
const Reference requiredAnnotation = Reference('required', materialImport);

TypeReference listRefer(Reference reference, {bool nullable = false}) =>
    TypeReference((b) => b
      ..symbol = "List"
      ..isNullable = nullable
      ..types.add(reference));

String generateLibrary(
  RouterConfig config, {
  bool usesPartBuilder = false,
  bool deferredLoading = false,
}) {
  throwIf(config.element == null,
      'Element is required for the Navigator2 Router. Something is broken');

  final fileName = config.element!.source.uri.pathSegments.last;

  throwIf(
    usesPartBuilder && deferredLoading,
    'Part-file approach will not work with deferred loading because allocator needs to mark all deferred imports!',
    element: config.element,
  );

  final emitter = DartEmitter(
    allocator: usesPartBuilder
        ? RouteAllocator()
        : DeferredPagesAllocator(config.routes, deferredLoading),
    orderDirectives: true,
    useNullSafetySyntax: true,
  );

  var allRouters = config.collectAllRoutersIncludingParent;
  List<RouteConfig> allRoutes =
      allRouters.fold(<RouteConfig>[], (acc, a) => acc..addAll(a.routes));

  final deferredRoutes = allRoutes.where((r) => r.deferredLoading == true);
  throwIf(
    usesPartBuilder && deferredRoutes.isNotEmpty,
    'Part-file approach will not work with deferred loading because allocator needs to mark all deferred imports! ${deferredRoutes.map((e) => e.name)}',
  );

  for (var i = 0; i < allRoutes.length; i++) {
    final route = allRoutes[i];
    if (deferredRoutes.any(
        (e) => e.pageType == route.pageType && route.deferredLoading != true)) {
      allRoutes[i] = route.copyWith(deferredLoading: true);
    }
  }

  final nonRedirectRoutes =
      allRoutes.where((r) => r.routeType != RouteType.redirect);
  final checkedRoutes = <RouteConfig>[];
  for (final route in nonRedirectRoutes) {
    throwIf(
      (checkedRoutes.any((r) =>
          r.routeName == route.routeName && r.pathName != route.pathName)),
      'Duplicate route names must have the same path! (name: ${route.routeName}, path: ${route.pathName})\nNote: Unless specified, route name is generated from page name.',
      element: config.element,
    );
    checkedRoutes.add(route);
  }

  var allGuards = allRoutes.fold<Set<ResolvedType>>(
    {},
    (acc, a) => acc..addAll(a.guards),
  );

  final originalRouterClasses = <Class>[];

  config.traverseRoutes(((routerConfig) {
    if (routerConfig.routes.isNotEmpty) {
      originalRouterClasses.add(RoutesClassBuilder(
        routes: routerConfig.routes,
        routesClassName: routerConfig.routesClassName,
      ).buildRoutesClass());

      originalRouterClasses.add(RouterClassBuilder(
        routesClassName: routerConfig.routesClassName,
        routes: routerConfig.routes,
        routerClassName: routerConfig.routerClassName,
      ).buildRouterClass());

      originalRouterClasses.addAll(ArgumentsClassBuilder(
        routes: routerConfig.routes,
      ).buildViewsArguments(emitter));
    }
  }));

  final navigationExtensionsClass = NavigateExtensionClassBuilder(
    routes: config.routes,
  ).build(emitter);

  final library = Library(
    (b) => b
      ..directives.addAll([
        if (usesPartBuilder) Directive.partOf(fileName),
        Directive.import('package:flutter/material.dart'),
      ])
      ..body.addAll([
        buildRouterConfig(config, allGuards, allRoutes),
        ...allRoutes
            .where((r) => r.routeType != RouteType.redirect)
            .distinctBy((e) => e.routeName)
            .map((r) => buildRouteInfoAndArgs(r, config, emitter))
            .reduce((acc, a) => acc..addAll(a)),
        ...originalRouterClasses,
        navigationExtensionsClass
      ]),
  );

  return [_header, DartFormatter().format(library.accept(emitter).toString())]
      .join('\n');
}

const String _header = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint
''';
