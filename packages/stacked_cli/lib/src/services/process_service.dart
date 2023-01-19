import 'dart:convert';
import 'dart:io';

import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';

/// helper service to run flutter commands
class ProcessService {
  final _analyticsService = locator<AnalyticsService>();
  final _cLog = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();

  late String _formattingLineLength;

  ProcessService() {
    _formattingLineLength = _configService.lineLength.toString();
  }

  set formattingLineLength(String? length) {
    _formattingLineLength = length ?? _configService.lineLength.toString();
  }

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

  /// Runs the flutter format . command on the app's source code.
  ///
  /// Args:
  ///   appName (String): The name of the app.
  Future<void> runFormat({String? appName, String? filePath}) async {
    await _runProcessAndLogOutput(
      programName: ksFlutter,
      arguments: [
        ksFormat,
        filePath ?? ksCurrentDirectory,
        '-l',
        _formattingLineLength
      ],
      workingDirectory: appName,
    );
  }

  /// It runs the `dart pub global` command in the app's directory
  Future<void> runPubGlobal() async {
    await _runProcessAndLogOutput(
      programName: ksDart,
      arguments: pubGlobalArguments,
    );
  }

  /// Runs the flutter analyze command and output the results to a file.
  Future<void> runAnalyzeAndWriteLogFile({String? appName}) async {
    await _runProcessInSilence(
      programName: ksFlutter,
      arguments: analyzeArguments,
      workingDirectory: appName,
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
        runInShell: true,
      );
      process.stdout.transform(utf8.decoder).forEach((output) {
        _cLog.flutterOutput(message: output);
      });

      final exitCode = await process.exitCode;

      logSuccessStatus(exitCode);
    } on ProcessException catch (e, s) {
      final message =
          'Command failed. Command executed: $programName ${arguments.join(' ')}\nException: ${e.message}';
      _cLog.error(message: message);
      _analyticsService.logExceptionEvent(
        runtimeType: e.runtimeType.toString(),
        message: message,
        stackTrace: s.toString(),
      );
    } catch (e, s) {
      final message =
          'Command failed. Command executed: $programName ${arguments.join(' ')}\nException: ${e.toString()}';
      _cLog.error(message: message);
      _analyticsService.logExceptionEvent(
        mode: ExceptionMode.unhandledException,
        runtimeType: e.runtimeType.toString(),
        message: message,
        stackTrace: s.toString(),
      );
    }
  }

  /// It runs a process without any log output
  ///
  /// Args:
  ///   programName (String): The name of the program to run.
  ///   arguments (List<String>): The arguments to pass to the program. Defaults to const []
  ///   workingDirectory (String): The directory to run the command in.
  Future<void> _runProcessInSilence({
    required String programName,
    List<String> arguments = const [],
    String? workingDirectory,
  }) async {
    try {
      await Process.run(
        programName,
        arguments,
        workingDirectory: workingDirectory,
        runInShell: true,
      );
    } on ProcessException catch (e, s) {
      final message =
          'Command failed. Command executed: $programName ${arguments.join(' ')}\nException: ${e.message}';
      _cLog.error(message: message);
      _analyticsService.logExceptionEvent(
        runtimeType: e.runtimeType.toString(),
        message: message,
        stackTrace: s.toString(),
      );
    } catch (e, s) {
      final message =
          'Command failed. Command executed: $programName ${arguments.join(' ')}\nException: ${e.toString()}';
      _cLog.error(message: message);
      _analyticsService.logExceptionEvent(
        mode: ExceptionMode.unhandledException,
        runtimeType: e.runtimeType.toString(),
        message: message,
        stackTrace: s.toString(),
      );
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
