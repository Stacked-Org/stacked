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
        '${hasPresolve ? 'Future' : 'void'} setupLocator({String? environment , EnvironmentFilter? environmentFilter}) ${hasPresolve ? 'async' : ''} {');

    newLine();
    writeLine('// Register environments');

    writeLine(
        'locator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);');

    newLine();
    writeLine('// Register dependencies');

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

    final String _formattedEnvs =
        _getFromatedEnvs(dependencyDefinition.environments ?? {});

    switch (dependencyDefinition.type) {
      case DependencyType.LazySingleton:
        return 'locator.registerLazySingleton$abstractionType(() => $singletonInstanceToReturn $_formattedEnvs);';
      case DependencyType.PresolvedSingleton:
        return '''
        final ${dependencyDefinition.camelCaseClassName} = await ${dependencyDefinition.className}.${dependencyDefinition.presolveFunction}();
        locator.registerSingleton$abstractionType(${dependencyDefinition.camelCaseClassName}  $_formattedEnvs);
        ''';
      case DependencyType.Factory:
        return 'locator.registerFactory$abstractionType(() => ${dependencyDefinition.className}()  $_formattedEnvs);';
      case DependencyType.Singleton:
      default:
        return 'locator.registerSingleton$abstractionType($singletonInstanceToReturn  $_formattedEnvs);';
    }
  }

  String _getFromatedEnvs(Set<String> envs) {
    final _envString = StringBuffer();
    if (envs.isEmpty) {
      return _envString.toString();
    }
    if (_envString.isEmpty) {
      _envString.write(',registerFor:{');
    }
    envs.forEach((element) {
      if (envs.first == element) {
        _envString.write('"$element"');
      } else {
        _envString.write(',"$element"');
      }
    });
    _envString.write('}');
    return _envString.toString();
  }

  void _generateImports(List<DependencyConfig> services) {
    // write route imports
    final imports = <String?>{
      "package:stacked/stacked.dart",
      "package:stacked/stacked_annotations.dart"
    };

    imports.addAll(services.map((service) => service.import));
    imports.addAll(services.map((service) => service.abstractedImport));

    var validImports =
        imports.where((import) => import != null).toSet().cast<String>();
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
