import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';

import '../router_2/resolvers/router_config_resolver.dart';
import '../router_common/resolvers/type_resolver.dart';
import 'generator/router_generator.dart';

class StackedRouterGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final libs = await buildStep.resolver.libraries.toList();
    final typeResolver = TypeResolver(libs);

    final routerConfig = RouterConfigResolver(typeResolver)
        .resolve(annotation, element as ClassElement);

    return RouterGenerator(routerConfig).generate();
  }
}
