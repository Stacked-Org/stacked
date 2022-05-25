import 'package:mockito/mockito.dart';
import 'package:stacked_tools/src/constants/config_constants.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/config_service.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

ConfigService _getService() => ConfigService();

void main() {
  group('ConfigService -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('isConfigFileAvailable -', () {
      test('when called should return true if the config file exists',
          () async {
        final service = _getService();
        final isAvailable = await service.isConfigFileAvailable();
        expect(isAvailable, isTrue);
      });

      test('when called should return false if the config file does not exists',
          () async {
        getAndRegisterMockFileService(fileExistsResult: false);
        final service = _getService();
        final isAvailable = await service.isConfigFileAvailable();
        expect(isAvailable, isFalse);
      });
    });

    group('loadConfig -', () {
      test('when called, should call fileExists on FileService', () async {
        final fileService = getAndRegisterMockFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig();
        verify(fileService.fileExists(filePath: kConfigFilePath));
      });

      test('when called, should call fileExists on FileService', () async {
        final fileService = getAndRegisterMockFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig();
        verify(fileService.readFileAsString(filePath: kConfigFilePath));
      });

      test(
          'when called and config json is malformed, should write error to console',
          () async {
        getAndRegisterMockFileService();
        final log = getAndRegisterColorizedLogService();
        final service = _getService();
        await service.loadConfig();
        verify(log.warn(message: kConfigFileMalformed));
      });

      test(
          'when called and config file not available, should NOT call fileExists on FileService',
          () async {
        final fileService = getAndRegisterMockFileService(
          fileExistsResult: false,
        );
        final service = _getService();
        await service.loadConfig();
        verifyNever(
          fileService.readFileAsString(filePath: kConfigFilePath),
        );
      });

      test(
          'when called and config file not available, should write error to console',
          () async {
        getAndRegisterMockFileService(fileExistsResult: false);
        final log = getAndRegisterColorizedLogService();
        final service = _getService();
        await service.loadConfig();
        verify(log.warn(message: kConfigFileNotFound));
      });
    });
  });
}
