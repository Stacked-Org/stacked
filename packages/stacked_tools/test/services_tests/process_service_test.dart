import 'package:mockito/mockito.dart';
import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';
import '../test_constants.dart';

ProcessService _getService() => ProcessService();

void main() {
  group('ProcessService -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
    group('runFormat -', () {
      test('when called should run flutter format . ', () async {
        var _clog = getAndRegisterColorizedLogService();
        var service = _getService();
        await service.runFormat();
        verify(_clog.stackedOutput(message: 'Running flutter format . ...'));
      });
      test('when called with appName should run flutter format . in appName ',
          () async {
        var _clog = getAndRegisterColorizedLogService();
        var service = _getService();
        await service.runFormat(appName: 'test');
        verify(_clog.stackedOutput(
            message: 'Running flutter format . in test/...'));
      });
      test('when called should run flutter format . and finish in exit code 0',
          () async {
        var _clog = getAndRegisterColorizedLogService();
        var service = _getService();
        await service.runFormat();
        verify(_clog.success(message: 'Command complete. ExitCode: 0'));
      });

      test(
          'when called should run flutter format . and ouput error if appName is not found',
          () async {
        var _clog = getAndRegisterColorizedLogService();
        var service = _getService();
        await service.runFormat(appName: "xyz");
        verify(_clog.error(message: anyNamed('message')));
      });
      test(
        "when called should format $ksFormatTestFileName",
        () async {
          String expected = '''int getSomeInt() {
  return 1;
}
''';
          final fileService = getAndRegisterFileService();
          createFormatTestFile();

          var service = getAndRegisterProcessService();
          await service.formatFile(
              workingDir: ksCurrentDirectory, fileName: ksFormatTestFileName);

          deleteFormatTestFile();
          expect(
              await fileService.readFileAsString(
                  filePath: ksFormatTestFileName),
              expected);
        },
      );
    });
  });
}
