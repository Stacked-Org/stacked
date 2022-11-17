import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';
import 'package:stacked_generator/src/generators/getit/stacked_locator_content_generator.dart';
import 'package:stacked_generator/utils.dart';

import 'dependency_config/dependency_config.dart';
import 'dependency_config_factory.dart';

class StackedLocatorGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    // ignore: avoid_renaming_method_parameters
    ConstantReader stackedApplication,
    BuildStep buildStep,
  ) async {
    final libs = await buildStep.resolver.libraries.toList();
    final importResolver = ImportResolver(libs, element.source?.uri.path ?? '');

    final String locatorName =
        stackedApplication.peek('locatorName')!.stringValue;

    final String locatorSetupName =
        stackedApplication.peek('locatorSetupName')!.stringValue;

    throwIf(
      locatorName.isEmpty || locatorSetupName.isEmpty,
      "Error: locatorName or locatorSetupName can not be empty string",
    );

    final dependenciesConfig =
        stackedApplication.peek('dependencies')?.listValue;
    if (dependenciesConfig == null) return '';

    List<DependencyConfig> dependencies = <DependencyConfig>[];
    // Convert the services config into Services configuration
    for (final dependencyConfig in dependenciesConfig) {
      final serialisedServiceConfig = DependencyConfigFactory.fromResolver(
        dependencyConfig: dependencyConfig,
        importResolver: importResolver,
      );
      dependencies.add(serialisedServiceConfig);
    }

    return StackedLocatorContentGenerator(
      dependencies: dependencies,
      locatorName: locatorName.toLowerCamelCase,
      locatorSetupName: locatorSetupName.toLowerCamelCase,
    ).generate();
  }
}
