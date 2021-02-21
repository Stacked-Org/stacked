import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/enums/serivce_type.dart';
import 'package:stacked_generator/src/generators/getit/service_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';

class GetItLocatorGenerator extends BaseGenerator {
  final ServicesConfig _servicesConfig;

  GetItLocatorGenerator(this._servicesConfig);

  String generate() {
    final services = _servicesConfig.services;
    writeLine("// ignore_for_file: public_member_api_docs");

    _generateImports(services);

    newLine();
    writeLine('final locator = GetIt.instance;');
    newLine();

    final hasPresolve = services
        .any((service) => service.type == ServiceType.PresolvedSingleton);

    writeLine(
        '${hasPresolve ? 'Future' : 'void'} setupLocator() ${hasPresolve ? 'async' : ''} {');

    // Loop through all service definitions and generate the code for it
    for (final serviceDefinition in services) {
      final registrationCodeForType =
          _getLocatorRegistrationStringForType(serviceDefinition);
      writeLine(registrationCodeForType);
    }

    writeLine('}');

    return stringBuffer.toString();
  }

  String _getLocatorRegistrationStringForType(ServiceConfig serviceDefinition) {
    switch (serviceDefinition.type) {
      case ServiceType.LazySingleton:
        return 'locator.registerLazySingleton(() => ${serviceDefinition.className}());';
      case ServiceType.PresolvedSingleton:
        return '''
        final ${serviceDefinition.camelCaseClassName} = await ${serviceDefinition.className}.${serviceDefinition.presolveFunction}();
        locator.registerSingleton(${serviceDefinition.camelCaseClassName});
        ''';
      case ServiceType.Factory:
        return 'locator.registerFactory(() => ${serviceDefinition.className}());';
      case ServiceType.Singleton:
      default:
        return 'locator.registerSingleton(${serviceDefinition.className}());';
    }
  }

  void _generateImports(List<ServiceConfig> services) {
    // write route imports
    final imports = <String>{"package:get_it/get_it.dart"};

    imports.addAll(services.map((e) => e.import));

    var validImports = imports.where((import) => import != null).toSet();
    var dartImports =
        validImports.where((element) => element.startsWith('dart')).toSet();
    sortAndGenerate(dartImports);
    newLine();

    var packageImports =
        validImports.where((element) => element.startsWith('package')).toSet();
    sortAndGenerate(packageImports);
    newLine();

    var rest = validImports.difference({...dartImports, ...packageImports});
    sortAndGenerate(rest);
  }
}
