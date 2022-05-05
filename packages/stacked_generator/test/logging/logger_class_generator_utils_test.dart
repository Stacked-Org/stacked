import 'package:stacked_generator/src/generators/logging/logger_class_generator.dart';
import 'package:test/test.dart';

void main() {
  group('LoggerClassGeneratorUtilsTest -', () {
    var utils;
    setUp(() {
      utils = LoggerClassGeneratorUtils();
    });
    group('generateMultiLoggers', () {
      test('''
Given two items one,two , Should return 
if(kReleaseMode) one(),if(kReleaseMode) two(),
''', () {
        expect(utils.addCheckForReleaseModeToEachLogger(['one', 'two']),
            " if(kReleaseMode) one(), if(kReleaseMode) two(),");
      });
    });
    group('generateImports', () {
      test('''
Given two items one,two, Should return import'one'; import'two';
''', () {
        expect(utils.surroundStringWithImportTemplate({'one', 'two'}), '''
import 'one';
import 'two';
''');
      });
    });
  });
}
