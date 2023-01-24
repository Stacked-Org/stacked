import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';

class GenerateCommand extends Command {
  final _processService = locator<ProcessService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      '''Generates the code for the stacked application if any changes were made''';

  @override
  String get name => 'generate';

  @override
  Future<void> run() async {
    unawaited(_analyticsService.generateCodeEvent());
    await _generateVersion();
    await _processService.runBuildRunner();
  }

  Future<void> _generateVersion() async {
    final pubspec = File('pubspec.yaml').readAsStringSync().toPubspecYaml();
    final version = pubspec.version.valueOr(() => '');

    final outputPath = joinAll([
      Directory.current.path,
      'lib',
      'src',
      'models',
      'version.g.dart',
    ]);

    final fileContent =
        "// GENERATED CODE - DO NOT MODIFY BY HAND\nconst String version = '$version';\n";
    await File(outputPath).writeAsString(fileContent);
  }
}
