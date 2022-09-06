const String logHelperNameKey = 'logHelperName';
const String multiLoggerImports = 'MultiLoggerImport';
const String multipleLoggerOutput = 'MultiLoggerList';
const String disableConsoleOutputInRelease = 'MultiLoggerList';

const String loggerClassPrefex = '''
// ignore_for_file: avoid_print

/// Maybe this should be generated for the user as well?
///
/// import 'package:customer_app/services/stackdriver/stackdriver_service.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
''';

const String loggerClassConstantBody = '''

class SimpleLogPrinter extends LogPrinter {
  final String className;
  final bool printCallingFunctionName;
  final bool printCallStack;
  final List<String> exludeLogsFromClasses;
  final String? showOnlyClass;

  SimpleLogPrinter(
    this.className, {
    this.printCallingFunctionName = true,
    this.printCallStack = false,
    this.exludeLogsFromClasses = const [],
    this.showOnlyClass,
  });

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    var methodName = _getMethodName();

    var methodNameSection =
        printCallingFunctionName && methodName != null ? ' | \$methodName ' : '';
    var stackLog = event.stackTrace.toString();
    var output =
        '\$emoji \$className\$methodNameSection - \${event.message}\${printCallStack ? '\\nSTACKTRACE:\\n\$stackLog' : ''}';

    if (exludeLogsFromClasses
            .any((excludeClass) => className == excludeClass) ||
        (showOnlyClass != null && className != showOnlyClass)) return [];

    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    List<String> result = [];

    for (var line in output.split('\\n')) {
      result.addAll(pattern.allMatches(line).map((match) {
        if (kReleaseMode) {
          return match.group(0)!;
        } else {
          return color!(match.group(0)!);
        }
      }));
    }

    return result;
  }

 String? _getMethodName() {
    try {
      final currentStack = StackTrace.current;
      final formattedStacktrace = _formatStackTrace(currentStack, 3);
      if (kIsWeb) {
        final classNameParts = _splitClassNameWords(className);
        return _findMostMatchedTrace(formattedStacktrace!, classNameParts)
            .split(' ')
            .last;
      } else {
        final realFirstLine = formattedStacktrace
            ?.firstWhere((line) => line.contains(className), orElse: () => "");

        final methodName = realFirstLine?.replaceAll('\$className.', '');
        return methodName;
      }
    } catch (e) {
      // There's no deliberate function call from our code so we return null;
      return null;
    }
  }

  List<String> _splitClassNameWords(String className) {
  return className
      .split(RegExp(r"(?=[A-Z])"))
      .map((e) => e.toLowerCase())
      .toList();
  }

  /// When the faulty word exists in the begging this method will not be very usefull
  String _findMostMatchedTrace(List<String> stackTraces, List<String> keyWords) {
    String match = stackTraces.firstWhere(
        (trace) => _doesTraceContainsAllKeywords(trace, keyWords),
        orElse: () => '');
    if (match.isEmpty) {
      match = _findMostMatchedTrace(
          stackTraces, keyWords.sublist(0, keyWords.length - 1));
    }
    return match;
  }

  bool _doesTraceContainsAllKeywords(String stackTrace, List<String> keywords) {
    final formattedKeywordsAsRegex = RegExp(\${keywords.join('.*')});
    return stackTrace.contains(formattedKeywordsAsRegex);
  }
}

final stackTraceRegex = RegExp(r'#[0-9]+[\\s]+(.+) \\(([^\\s]+)\\)');

List<String>? _formatStackTrace(StackTrace stackTrace, int methodCount) {
  var lines = stackTrace.toString().split('\\n');

  var formatted = <String>[];
  var count = 0;
  for (var line in lines) {
    var match = stackTraceRegex.matchAsPrefix(line);
    if (match != null) {
      if (match.group(2)!.startsWith('package:logger')) {
        continue;
      }
      var newLine = ("\${match.group(1)}");
      formatted.add(newLine.replaceAll('<anonymous closure>', '()'));
      if (++count == methodCount) {
        break;
      }
    } else {
      formatted.add(line);
    }
  }

  if (formatted.isEmpty) {
    return null;
  } else {
    return formatted;
  }
}

class MultipleLoggerOutput extends LogOutput {
  final List<LogOutput> logOutputs;
  MultipleLoggerOutput(this.logOutputs);

  @override
  void output(OutputEvent event) {
    for (var logOutput in logOutputs) {
      try {
        logOutput.output(event);
      } catch (e) {
        print('Log output failed');
      }
    }
  }
}

''';

const String loggerClassNameAndOutputs = '''
Logger $logHelperNameKey(
  String className, {
  bool printCallingFunctionName = true,
  bool printCallstack = false,
  List<String> exludeLogsFromClasses = const [],
  String? showOnlyClass,
}) {
  return Logger(
    printer: SimpleLogPrinter(
      className,
      printCallingFunctionName: printCallingFunctionName,
      printCallStack: printCallstack,
      showOnlyClass: showOnlyClass,
      exludeLogsFromClasses: exludeLogsFromClasses,
    ),
    output: MultipleLoggerOutput([
      $disableConsoleOutputInRelease
      ConsoleOutput(),
      $multipleLoggerOutput
    ]),
  );
}
''';
