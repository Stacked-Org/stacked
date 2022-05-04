import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';
import 'package:stacked_generator/utils.dart';

class StackedLocatorContentGenerator extends BaseGenerator {
  final String locatorName;
  final String locatorSetupName;
  final ServicesConfig servicesConfig;

  StackedLocatorContentGenerator({
    required this.servicesConfig,
    required this.locatorName,
    required this.locatorSetupName,
  });
  @override
  String generate() {
    final services = servicesConfig.services;
    writeLine("// ignore_for_file: public_member_api_docs");

    _generateImports(services);

    newLine();
    writeLine('final $locatorName = StackedLocator.instance;');
    newLine();

    final hasPresolve = services
        .any((service) => service.type == DependencyType.PresolvedSingleton);

    writeLine(
        '${hasPresolve ? 'Future' : 'void'} $locatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) ${hasPresolve ? 'async' : ''} {');

    newLine();
    writeLine('// Register environments');

    writeLine(
        '$locatorName.registerEnvironment(environment: environment, environmentFilter: environmentFilter);');

    newLine();
    writeLine('// Register dependencies');

    // Loop through all service definitions and generate the code for it
    for (final serviceDefinition in services) {
      final registrationCodeForType = _getLocatorRegistrationStringForType(
        locatorName: locatorName,
        dependencyDefinition: serviceDefinition,
      );
      writeLine(registrationCodeForType);
    }

    writeLine('}');

    return stringBuffer.toString();
  }

  String _getLocatorRegistrationStringForType({
    required String locatorName,
    required DependencyConfig dependencyDefinition,
  }) {
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

    final _params = _getParameters(dependencyDefinition);

    switch (dependencyDefinition.type) {
      case DependencyType.LazySingleton:
        return '$locatorName.registerLazySingleton$abstractionType(() => $singletonInstanceToReturn $_formattedEnvs);';
      case DependencyType.PresolvedSingleton:
        return '''
        final ${dependencyDefinition.camelCaseClassName} = await ${dependencyDefinition.className}.${dependencyDefinition.presolveFunction}();
        $locatorName.registerSingleton$abstractionType(${dependencyDefinition.camelCaseClassName}  $_formattedEnvs);
        ''';
      case DependencyType.Factory:
        return '$locatorName.registerFactory$abstractionType(() => ${dependencyDefinition.className}()  $_formattedEnvs);';
      case DependencyType.FactoryWithParam:
        throwIf(
          _params["params"]?.isEmpty ?? true,
          "At least one paramter is requerd for FactoryWithParam registration ",
        );
        return '$locatorName.registerFactoryParam<${dependencyDefinition.className},${_params["paramTypes"]}>$abstractionType((param1, param2) => ${dependencyDefinition.className}(${_params["params"]})  $_formattedEnvs);';
      case DependencyType.Singleton:
      default:
        return '$locatorName.registerSingleton$abstractionType($singletonInstanceToReturn  $_formattedEnvs);';
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

  Map<String, String> _getParameters(DependencyConfig dependencyConfig) {
    final factoryParamList =
        dependencyConfig.params?.where((element) => element.isFactoryParam);
    final int paramLength = factoryParamList?.length ?? 0;

    throwIf(
      paramLength > 2,
      "Max number of factory params supported by get_it is 2",
    );

    final Set<String> constructorParams = {};
    final List<String> constructorParamTypes = [];
    factoryParamList!.toList().asMap().forEach((index, param) {
      String getterName;

      throwIf(
        !param.type!.contains("?"),
        "Factory params must be nullable. Parameter ${param.name} is not nullable",
      );

      getterName =
          "param${index + 1}${param.defaultValueCode != null ? ' ?? ${param.defaultValueCode}' : ''}";

      if (param.isPositional) {
        constructorParams.add(getterName);
      } else {
        constructorParams.add('${param.name}:$getterName');
      }

      constructorParamTypes.add('${param.type}');
    });

    if (paramLength == 1) {
      constructorParamTypes.add('dynamic');
    }

    final params = constructorParams.toString().replaceAll(RegExp('[{}]'), '');
    final paramtypes =
        constructorParamTypes.toString().replaceAll(RegExp(r'[\[\]]'), '');

    return {
      "params": params,
      "paramTypes": paramtypes,
    };
  }

  void _generateImports(List<DependencyConfig> services) {
    // write route imports
    final imports = <String?>{
      "package:stacked/stacked.dart",
      "package:stacked/stacked_annotations.dart"
    };

    imports.addAll(services.map((service) => service.import));
    imports.addAll(services.map((service) => service.abstractedImport));

    services.forEach((element) {
      if (element.params != null) {
        element.params!.forEach((im) {
          if (im.imports != null) {
            imports.addAll(im.imports!);
          }
        });
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
