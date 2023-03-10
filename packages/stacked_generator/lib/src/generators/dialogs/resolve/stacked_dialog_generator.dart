import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_shared/stacked_shared.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/dialogs/generate/dialog_class_generator.dart';

import 'dialog_config_resolver.dart';

class StackedDialogGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final dialogResolver = DialogConfigResolver();
    final libs = await buildStep.resolver.libraries.toList();
    final importResolver = ImportResolver(libs, element.source?.uri.path ?? '');

    /// If the dialogs parameter is not mentioned in the StackedApp
    /// return empty string
    final dialogsConfig = annotation.peek('dialogs')?.listValue;
    final locatorName = annotation.peek('locatorName')?.stringValue;

    if (dialogsConfig == null) return '';

    final dialogConfig = dialogResolver.resolve(
      dialogsConfig,
      importResolver,
    );

    return DialogClassGenerator(dialogConfig, locatorName: locatorName)
        .generate();
  }
}
