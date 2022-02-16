import 'dart:io';

import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

/// Definition of a function that when executed returns a Map<String, String>
typedef RenderFunction = Map<String, String> Function(ReCase value);

// TODO: Replace this terrible implementation
String _getPackageName() {
  // TODO: We need to be able to unit test this (will become important if it ever breaks somethings)
  final pubspecYaml = File('pubspec.yaml').readAsStringSync().toPubspecYaml();
  return pubspecYaml.name;
}

Map<String, RenderFunction> renderFunctions = {
  kTemplateNameView: (ReCase value) {
    return {
      kTemplatePropertyViewName: '${value.pascalCase}View',
      kTemplatePropertyViewModelName: '${value.pascalCase}ViewModel',
      kTemplatePropertyViewModelFileName: '${value.snakeCase}_viewmodel.dart',
      kTemplatePropertyPackageName: _getPackageName(),
    };
  },
  kTemplateNameService: (ReCase value) => {
        kTemplatePropertyServiceName: value.pascalCase,
        kTemplatePropertyPackageName: _getPackageName(),
        kTemplatePropertyServiceFilename: '${value.snakeCase}_service.dart',
      },
};
