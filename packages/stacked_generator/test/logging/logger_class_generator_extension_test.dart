import 'package:stacked_generator/src/generators/logging/logger_class_generator.dart';
import 'package:test/test.dart';

void main() {
  group('LoggerClassGeneratorExtensionTest -', () {
    group('generateMultiLoggers', () {
      test('''
Given two items one,two , Should return 
if(kReleaseMode) one(),if(kReleaseMode) two(),
''', () {
        expect(['one', 'two'].addCheckForReleaseModeToEachLogger,
            " if(kReleaseMode) one(), if(kReleaseMode) two(),");
      });
    });
  });
}
