import 'package:analyzer/dart/element/element.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/router_class_generator.dart';

class StackedRouterGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    var libs = await buildStep.resolver.libraries.toList();
    var importResolver = ImportResolver(libs, element.source?.uri.path ?? '');

    var routerResolver = RouterConfigResolver(importResolver);
    final routerConfig = await routerResolver.resolve(
      annotation,
    );

    return RouterClassGenerator(routerConfig).generate();
  }
}
