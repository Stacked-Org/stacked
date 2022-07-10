import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/router_generator.dart';

class StackedRouterGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final libs = await buildStep.resolver.libraries.toList();
    final importResolver = ImportResolver(libs, element.source?.uri.path ?? '');

    final routerConfig =
        await RouterConfigResolver(importResolver).resolve(annotation);

    if (routerConfig != null)
      return RouterGenerator(routerConfig).generate();
    else
      return '';
  }
}
