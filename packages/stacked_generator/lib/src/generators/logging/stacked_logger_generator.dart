import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'logger_class_generator.dart';
import 'logger_config_resolver.dart';

class StackedLoggerGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    var loggerResolver = LoggerConfigResolver();
    final loggerConfig = await loggerResolver.resolve(
      annotation,
    );

    if (loggerConfig != null) {
      return LoggerClassGenerator(loggerConfig).generate();
    }

    return Future.value('');
  }
}
