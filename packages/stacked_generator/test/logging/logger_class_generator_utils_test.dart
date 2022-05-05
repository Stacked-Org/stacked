import 'package:stacked_generator/src/generators/logging/logger_class_generator.dart';
import 'package:test/test.dart';

void main() {
  group('LoggerClassGeneratorUtilsTest -', () {
    group('generateMultiLoggers', () {
      test('''
Given two items one,two , Should return 
if(kReleaseMode) one(),if(kReleaseMode) two(),
''', () {
        expect(['one', 'two'].addCheckForReleaseModeToEachLogger,
            " if(kReleaseMode) one(), if(kReleaseMode) two(),");
      });
    });
    group('generateImports', () {
      test('''
Given two items one,two, Should return import'one'; import'two';
''', () {
        expect({'one', 'two'}.surroundStringWithImportTemplate, '''
import 'one';
import 'two';
''');
      });
    });
  });
}
