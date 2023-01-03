import 'package:mockito/mockito.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

ProcessService _getService() => ProcessService();

void main() {
  group('ProcessService -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
    group('runFormat -', () {
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
    });
  });
}
