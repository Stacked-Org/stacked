import 'package:stacked_generator/src/generators/extensions/list_utils_extension.dart';
import 'package:test/test.dart';

void main() {
  group('LoggerClassGeneratorExtensionTest -', () {
    group('generateMultiLoggers', () {
      test('''
Given two items one,two , Should return 
if(kReleaseMode) one(),if(kReleaseMode) two(),
''', () {
        expect(['one', 'two'].addCheckForReleaseModeToEachLogger,
            " if(_isReleaseMode) one(), if(_isReleaseMode) two(),");
      });
    });
  });
}
