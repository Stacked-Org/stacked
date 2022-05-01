import 'dart:io';

import 'package:pubspec_yaml/pubspec_yaml.dart';

/// Provides functionality to interact with the pubspec in the current project
class PubspecService {
  late PubspecYaml pubspecYaml;

  /// Reads the pubpec and caches the value locally
  Future<void> initialise() async {
    // stdout.writeln('PubspecService - initialise from pubspec.yaml');
    final pubspecYamlContent = await File('pubspec.yaml').readAsString();
    pubspecYaml = pubspecYamlContent.toPubspecYaml();
    // stdout.writeln('PubspecService - initialise complete');
  }

  String get getPackageName => pubspecYaml.name;
}
