import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/factory_param_dependency.dart';

import 'dependency_config/dependency_config.dart';

class StackedLocatorContentGenerator extends BaseGenerator {
  final String locatorName;
  final String locatorSetupName;
  final List<DependencyConfig> dependencies;

  StackedLocatorContentGenerator({
    required this.dependencies,
    required this.locatorName,
    required this.locatorSetupName,
  });
  @override
  String generate() {
    writeLine("// ignore_for_file: public_member_api_docs");

    _generateImports(dependencies);

    newLine();
    writeLine('final $locatorName = StackedLocator.instance;');
    newLine();

    writeLine(
        'Future<void> $locatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) async {');

    newLine();
    writeLine('// Register environments');

    writeLine(
        '$locatorName.registerEnvironment(environment: environment, environmentFilter: environmentFilter);');

    newLine();
    writeLine('// Register dependencies');

    // Loop through all service definitions and generate the code for it
    for (final dependency in dependencies) {
      final registerDependenciesCode =
          dependency.registerDependencies(locatorName);
      writeLine(registerDependenciesCode);
    }

    writeLine('}');

    return serializeStringBuffer;
  }

  void _generateImports(List<DependencyConfig> services) {
    // write route imports
    final imports = <String?>{
      // "package:stacked/stacked.dart",
      "package:stacked_core/stacked_core.dart"
    };

    imports.addAll(services.map((service) => service.import));
    imports.addAll(services.map((service) => service.abstractedImport));

    services.forEach((dependency) {
      if (dependency is FactoryParamDependency) {
        imports.addAll(dependency.extraImports());
      }
    });

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
