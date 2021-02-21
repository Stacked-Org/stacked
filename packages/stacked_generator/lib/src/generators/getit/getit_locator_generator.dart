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

    // TODO: Check for void or Future and write accordingly
    // write('void' or 'Future')
    writeLine('void setupLocator() {');

    // Loop through all service definitions and generate the code for it
    for (final serviceDefinition in services) {
      switch (serviceDefinition.type) {
        case ServiceType.Factory:
          writeLine(
              'locator.registerFactory(() => ${serviceDefinition.className}());');
          break;
        case ServiceType.Singleton:
          writeLine(
              'locator.registerSingleton(${serviceDefinition.className}());');
          break;
        case ServiceType.LazySingleton:
          writeLine(
              'locator.registerLazySingleton(() => ${serviceDefinition.className}());');
          break;
        case ServiceType.PresolvedSingleton:
          writeLine(
              'locator.registerFactory(() => ${serviceDefinition.className}());');
          break;
        default:
      }
    }

    writeLine('}');

    return stringBuffer.toString();
  }

  void _generateImports(List<ServiceConfig> services) {
    // write route imports
    final imports = <String>{
      "package:stacked/stacked.dart",
      "package:get_it/get_it.dart"
    };

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
