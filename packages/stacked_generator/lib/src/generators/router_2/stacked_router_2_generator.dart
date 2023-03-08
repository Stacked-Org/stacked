import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/route_config_resolver.dart';

import '../router_common/resolvers/type_resolver.dart';
import 'router_2_generator.dart';

class StackedRouter2Generator extends GeneratorForAnnotation<StackedApp> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final libs = await buildStep.resolver.libraries.toList();
    final typeResolver = TypeResolver(libs);

    final routerConfig =
        await RouterConfigResolver(typeResolver).resolve(annotation);

    if (routerConfig != null) {
      return Router2Generator().generate();
    } else {
      return '';
    }
  }
}
