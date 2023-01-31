import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/bottomsheets/generate/bottomsheet_class_generator.dart';

import 'bottomsheet_config_resolver.dart';

class StackedBottomsheetGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final bottomsheetResolver = BottomsheetConfigResolver();
    final libs = await buildStep.resolver.libraries.toList();
    final importResolver = ImportResolver(libs, element.source?.uri.path ?? '');

    /// If the bottomsheets parameter is not mentioned in the StackedApp
    /// return empty string
    final bottomsheetsConfig = annotation.peek('bottomsheets')?.listValue;
    final locatorName = annotation.peek('locatorName')?.stringValue;

    if (bottomsheetsConfig == null) return '';

    final dialogConfig = bottomsheetResolver.resolve(
      bottomsheetsConfig,
      importResolver,
    );

    return BottomsheetClassGenerator(dialogConfig, locatorName: locatorName)
        .generate();
  }
}
