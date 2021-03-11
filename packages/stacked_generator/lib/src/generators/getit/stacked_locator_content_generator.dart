import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';

class StackedLocatorContentGenerator extends BaseGenerator {
  final ServicesConfig _servicesConfig;

  StackedLocatorContentGenerator(this._servicesConfig);

  String generate() {
    final services = _servicesConfig.services;
    writeLine("// ignore_for_file: public_member_api_docs");

    _generateImports(services);

    newLine();
    writeLine('final locator = StackedLocator.instance;');
    newLine();

    final hasPresolve = services
        .any((service) => service.type == DependencyType.PresolvedSingleton);

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

  String _getLocatorRegistrationStringForType(
      DependencyConfig dependencyDefinition) {
    final hasAbstratedType =
        dependencyDefinition.abstractedTypeClassName != null;
    final abstractionType = hasAbstratedType
        ? '<${dependencyDefinition.abstractedTypeClassName}>'
        : '';

    final hasResolveFunction = dependencyDefinition.resolveFunction != null;
    final singletonInstanceToReturn = hasResolveFunction
        ? '${dependencyDefinition.className}.${dependencyDefinition.resolveFunction}()'
        : '${dependencyDefinition.className}()';

    switch (dependencyDefinition.type) {
      case DependencyType.LazySingleton:
        return 'locator.registerLazySingleton$abstractionType(() => $singletonInstanceToReturn);';
      case DependencyType.PresolvedSingleton:
        return '''
        final ${dependencyDefinition.camelCaseClassName} = await ${dependencyDefinition.className}.${dependencyDefinition.presolveFunction}();
        locator.registerSingleton$abstractionType(${dependencyDefinition.camelCaseClassName});
        ''';
      case DependencyType.Factory:
        return 'locator.registerFactory$abstractionType(() => ${dependencyDefinition.className}());';
      case DependencyType.Singleton:
      default:
        return 'locator.registerSingleton$abstractionType($singletonInstanceToReturn);';
    }
  }

  void _generateImports(List<DependencyConfig> services) {
    // write route imports
    final imports = <String>{"package:stacked/stacked.dart"};

    imports.addAll(services.map((e) => e.import));
    imports.addAll(services.map((e) => e.abstractedImport));

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
