import 'dart:convert';
import 'dart:io';

import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';

/// helper service to run flutter commands
class ProcessService {
  final _cLog = locator<ColorizedLogService>();

  /// It creates a new flutter app.
  ///
  /// Args:
  ///   appName (String): The name of the app that's going to be create.
  Future<void> runCreateApp({required String appName}) async {
    await _runProcessAndLogOutput(
      programName: ksFlutter,
      arguments: [ksCreate, appName],
    );
  }

  /// Run the `pub run build_runner build --delete-conflicting-outputs` command in the `appName` directory
  ///
  /// Args:
  ///   appName (String): The name of the app.
  Future<void> runBuildRunner({String? appName}) async {
    await _runProcessAndLogOutput(
      programName: ksFlutter,
      arguments: buildRunnerArguments,
      workingDirectory: appName,
    );
  }

  /// It runs the `flutter pub get` command in the app's directory
  ///
  /// Args:
  ///   appName (String): The name of the app.
  Future<void> runPubGet({String? appName}) async {
    await _runProcessAndLogOutput(
      programName: ksFlutter,
      arguments: pubGetArguments,
      workingDirectory: appName,
    );
  }

  /// "Runs the flutter format . command on the app's source code."
  ///
  /// Args:
  ///   appName (String): The name of the app.
  Future<void> runFormat({String? appName}) async {
    await _runProcessAndLogOutput(
      programName: ksFlutter,
      arguments: [ksFormat, ksCurrentDirectory],
      workingDirectory: appName,
    );
  }

  /// "Runs the dart format for the file int the provided path."
  ///
  /// Args:
  ///   workingDir (String): The path to the folder in which the file is present to be formatted
  ///   (the path can be relative or absolute).
  ///   fileName (String): The name of the file to formatted.
  Future<void> formatFile({String? workingDir, String? fileName}) async {
    await _runProcessAndLogOutput(
      programName: ksDart,
      arguments: [ksFormat, fileName!, '--set-exit-if-changed'],
      workingDirectory: workingDir,
    );
  }

  /// It runs a process and logs the output to the console
  ///
  /// Args:
  ///   programName (String): The name of the program to run.
  ///   arguments (List<String>): The arguments to pass to the program. Defaults to const []
  ///   workingDirectory (String): The directory to run the command in.
  Future<void> _runProcessAndLogOutput({
    required String programName,
    List<String> arguments = const [],
    String? workingDirectory,
  }) async {
    final hasWorkingDirectory = workingDirectory != null;
    _cLog.stackedOutput(
        message:
            'Running $programName ${arguments.join(' ')} ${hasWorkingDirectory ? 'in $workingDirectory/' : ''}...');
    try {
      var process = await Process.start(
        programName,
        arguments,
        workingDirectory: workingDirectory,
      );
      process.stdout.transform(utf8.decoder).forEach((output) {
        _cLog.flutterOutput(message: output);
      });

      final exitCode = await process.exitCode;

      logSuccessStatus(exitCode);
    } on ProcessException catch (e) {
      _cLog.error(message: 'Command failed. ${e.message}');
    }
  }

  /// If the exit code is 0, log a success message, otherwise log an error message
  ///
  /// Args:
  ///   exitCode (int): The exit code of the command.
  ///
  void logSuccessStatus(int exitCode) {
    if (exitCode == 0) {
      _cLog.success(
        message: 'Command complete. ExitCode: $exitCode',
      );
      return;
    }
    _cLog.error(
      message: 'Command complete. ExitCode: $exitCode',
    );
  }
}
