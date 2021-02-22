import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/core/logger.dart';
import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';
import 'package:stacked_generator/utils.dart';

import 'getit_locator_generator.dart';

const stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

class StackedGetItGenerator extends GeneratorForAnnotation<StackedApp> {
  final log = getLogger('StackedGetItGenerator');

  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader stackedApplication,
    BuildStep buildStep,
  ) async {
    var libs = await buildStep.resolver.libraries.toList();
    var importResolver = ImportResolver(libs, element.source.uri.path);

    final servicesConfig = stackedApplication.peek('dependencies')?.listValue;
    if (servicesConfig != null) {
      List<DependencyConfig> services = List<DependencyConfig>();
      // Convert the services config into Services configuration
      for (final serviceConfig in servicesConfig) {
        final serialisedServiceConfig = _readDependencyConfig(
          dependencyConfig: serviceConfig,
          importResolver: importResolver,
        );
        services.add(serialisedServiceConfig);
      }

      return GetItLocatorGenerator(ServicesConfig(services: services))
          .generate();
    }
  }

  DependencyConfig _readDependencyConfig({
    DartObject dependencyConfig,
    ImportResolver importResolver,
  }) {
    var dependencyReader = ConstantReader(dependencyConfig);
    // Get the type of the service that we want to register
    final dependencyClassType = dependencyReader.read('classType').typeValue;

    throwIf(
      dependencyClassType == null,
      '🛑 No depedency class Type defined for ${dependencyConfig.toString()}. Please make sure that any of the services provided to the services list in the StackedApp annotation has a service provided. Please see the documentation for stacked_generator if you don\'t know what this means.',
    );

    final classElement = dependencyClassType.element as ClassElement;

    throwIf(
      classElement == null,
      '🛑 ${dependencyClassType.getDisplayString()} is not a class element. All services should be classes. We don\'t register individual values for global access through the locator. Make sure the value provided as your service type is a class.',
    );

    // Get the import of the class type that's defined for the service
    final import = importResolver.resolve(classElement);

    final className = dependencyClassType.getDisplayString();

    // NOTE: This can be used for actual dependency inject. We do service location instead.
    final constructor = classElement.unnamedConstructor;

    final serviceType = _getDependencyType(dependencyReader);
    String presolveFunction;
    if (serviceType == DependencyType.PresolvedSingleton) {
      final presolveUsing = dependencyReader.read('presolveUsing');
      final presolveObject = presolveUsing.objectValue.toFunctionValue();
      presolveFunction = presolveObject.displayName;
      log.d(
          'presolveUsing:$presolveUsing objectValue:${presolveObject.toString()} presolveFunction:$presolveFunction');
    }

    return DependencyConfig(
      className: className,
      import: import,
      type: serviceType,
      presolveFunction: presolveFunction,
    );
  }

  DependencyType _getDependencyType(ConstantReader serviceReader) {
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(Factory))) {
      return DependencyType.Factory;
    }
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(Singleton))) {
      return DependencyType.Singleton;
    }
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(LazySingleton))) {
      return DependencyType.LazySingleton;
    }
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(Presolve))) {
      return DependencyType.PresolvedSingleton;
    }

    return DependencyType.Singleton;
  }
}
