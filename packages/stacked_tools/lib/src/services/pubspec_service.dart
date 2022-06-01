import 'dart:io';

import 'package:pubspec_yaml/pubspec_yaml.dart';

/// Provides functionality to interact with the pubspec in the current project
class PubspecService {
  late PubspecYaml pubspecYaml;

  /// Reads the pubspec and caches the value locally
  Future<void> initialise({String? workingDirectory}) async {
    final bool hasWorkingDirectory = workingDirectory != null;
    // stdout.writeln('PubspecService - initialise from pubspec.yaml');
    final pubspecYamlContent = await File(
            '${hasWorkingDirectory ? '$workingDirectory/' : ''}pubspec.yaml')
        .readAsString();
    pubspecYaml = pubspecYamlContent.toPubspecYaml();
    // stdout.writeln('PubspecService - initialise complete');
  }

  String get getPackageName => pubspecYaml.name;
}
