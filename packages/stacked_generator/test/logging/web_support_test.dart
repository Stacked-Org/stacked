import 'package:test/test.dart';

List<String> _spliteClassNameWords(String className) {
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
  final formattedKeywordsAsRegex = RegExp("${keywords.join('.*')}");
  return stackTrace.contains(formattedKeywordsAsRegex);
}

void main() {
  group('WebSupportTest -', () {
    const exampleStackTraceOfWebAppLog = [
      "dart-sdk/lib/_internal/js_dev_runtime/patch/core_patch.dart 963:28   get current",
      "packages/intake/app/app.logger.dart 68:39                            [_getMethodName]",
      "packages/intake/app/app.logger.dart 38:22                            log",
      "packages/logger/src/logger.dart 115:29                               log"
          "packages/logger/src/logger.dart 75:5                                 v",
      "packages/intake/services/user_service.dart 26:9                      syncUserAccount",
      "dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 84:54   runBody",
      "dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 123:5   _async",
      "packages/intake/services/user_service.dart 22:31                     syncUserAccount",
      "packages/intake/main.dart 29:32                                      main\$",
      "dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 45:50   <fn>",
      "dart-sdk/lib/async/zone.dart 1685:54                                 runUnary",
      "dart-sdk/lib/async/future_impl.dart 147:18                           handleValue",
      "dart-sdk/lib/async/future_impl.dart 766:44                           handleValueCallback",
      "dart-sdk/lib/async/future_impl.dart 795:13                           _propagateToListeners",
      "dart-sdk/lib/async/future_impl.dart 566:5                            [_completeWithValue]",
      "dart-sdk/lib/async/future_impl.dart 639:7                            callback",
      "dart-sdk/lib/async/schedule_microtask.dart 40:11                     _microtaskLoop",
      "dart-sdk/lib/async/schedule_microtask.dart 49:5                      _startMicrotaskLoop",
    ];
    const example2StackTraceOfWebAppLog = [
      "packages/intake/app/app.user.dart 38:22                            log",
      "packages/intake/services/user_service.dart 26:9                      syncUserAccount",
      "packages/intake/services/user_service.dart 22:31                     syncUserAccount",
    ];
    group('convertClassNameToFileName -', () {
      test(
          'When class name is UserService, Should return two words [user, service]',
          () {
        expect(_spliteClassNameWords('UserService'), ['user', 'service']);
      });
      group('_doesTraceContainsAllKeywords -', () {
        test(
            'When call on a trace, Should return true if it contains all the words and false otherwise ',
            () {
          final trace =
              "packages/intake/services/user_service.dart 26:9                      syncUserAccount";

          expect(_doesTraceContainsAllKeywords(trace, ['user', 'service']),
              isTrue);

          expect(_doesTraceContainsAllKeywords(trace, ['user', 'greate']),
              isFalse);
        });
      });
      group('_findMostMatchedTrace -', () {
        test(
            'When call on a list of traces, Should return the first most matched trace with the provided keywords',
            () {
          final firstMostMatchedTrace = _findMostMatchedTrace(
              exampleStackTraceOfWebAppLog, ['user', 'service']);

          expect(firstMostMatchedTrace, exampleStackTraceOfWebAppLog[4]);
          expect(firstMostMatchedTrace, example2StackTraceOfWebAppLog[1]);
        });
        test(
            'When call on a list of traces and don\'t find all the keywords, Should remove a keyword from the list and try again',
            () {
          final firstMostMatchedTrace = _findMostMatchedTrace(
              exampleStackTraceOfWebAppLog, ['user', 'service', 'office']);

          expect(firstMostMatchedTrace, exampleStackTraceOfWebAppLog[4]);
        });
        test('Given a stacktrace from web log, Should return method name', () {
          expect(
              _findMostMatchedTrace(exampleStackTraceOfWebAppLog,
                  ['user', 'service', 'office']).split(' ').last,
              'syncUserAccount');
        });
      });
    });
  });
}
