import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/enums/serivce_type.dart';
import 'package:stacked_generator/src/generators/getit/service_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';
import 'package:stacked_generator/utils.dart';

import 'getit_locator_generator.dart';

const stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

class StackedGetItGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader stackedApplication,
    BuildStep buildStep,
  ) async {
    var libs = await buildStep.resolver.libraries.toList();
    var importResolver = ImportResolver(libs, element.source.uri.path);

    final servicesConfig = stackedApplication.read('routes').listValue;

    List<ServiceConfig> services = List<ServiceConfig>();
    // Convert the services config into Services configuration
    for (final serviceConfig in servicesConfig) {
      var serviceReader = ConstantReader(serviceConfig);

      // Get the type of the service that we want to register
      final serviceClassType = serviceReader.read('service').typeValue;

      throwIf(
        serviceClassType == null,
        '🛑 No service class Type defined for ${serviceConfig.toString()}. Please make sure that any of the services provided to the services list in the StackedApp annotation has a service provided. Please see the documentation for stacked_generator if you don\'t know what this means.',
      );

      final classElement = serviceClassType.element as ClassElement;

      throwIf(
        classElement == null,
        '🛑 ${serviceClassType.getDisplayString()} is not a class element. All services should be classes. We don\'t register individual values for global access through the locator. Make sure the value provided as your service type is a class.',
      );

      // Get the import of the class type that's defined for the service
      final import = importResolver.resolve(classElement);

      final className = serviceClassType.getDisplayString();

      // NOTE: This can be used for actual dependency inject. We do service location instead.
      final constructor = classElement.unnamedConstructor;

      final serviceType = _getServiceType(serviceReader);

      services.add(ServiceConfig(
        className: className,
        import: import,
        type: serviceType,
      ));
    }

    return GetItLocatorGenerator(ServicesConfig(services: services)).generate();
  }

  ServiceType _getServiceType(ConstantReader serviceReader) {
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(Factory))) {
      return ServiceType.Factory;
    }
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(Singleton))) {
      return ServiceType.Singleton;
    }
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(LazySingleton))) {
      return ServiceType.LazySingleton;
    }
    if (serviceReader.instanceOf(TypeChecker.fromRuntime(Presolve))) {
      return ServiceType.PresolvedSingleton;
    }

    return ServiceType.Singleton;
  }
}
