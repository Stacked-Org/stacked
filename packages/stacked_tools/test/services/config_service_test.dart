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

    const stackedAppFilePath = 'src/lib/app/core.dart';
    const testHelpersFilePath = 'lib/src/test/helpers/core_test.helpers.dart';

    const String customConfig = '''
      {
        "stacked_app_file_path": "$stackedAppFilePath",
        "views_path": "lib/my/personal/path/to/views",
        "services_path": "lib/my/personal/path/to/services",
        "test_services_path": "test/my/personal/path/to/tests/service",
        "test_views_path": "test/my/personal/path/to/tests/viewmodel",
        "test_helpers_file_path": "$testHelpersFilePath"
      }
    ''';

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

    group('replaceCustomPaths -', () {
      test('when called without custom config should return same path',
          () async {
        final path = 'test/services/generic_service_test.dart.stk';
        getAndRegisterMockFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig();
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, path);
      });

      test('when called with custom config should return custom path',
          () async {
        final path = 'test/services/generic_service_test.dart.stk';
        getAndRegisterMockFileService(readFileResult: customConfig);
        final service = _getService();
        await service.loadConfig();
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, isNot(path));
        expect(
          customPath,
          'test/my/personal/path/to/tests/service/generic_service_test.dart.stk',
        );
      });

      test(
          'when called with custom stacked app file path should return full stacked_app file path from config',
          () async {
        final path = 'lib/app/app.dart';
        getAndRegisterMockFileService(readFileResult: customConfig);
        final service = _getService();
        await service.loadConfig();
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, isNot(path));
        expect(customPath, stackedAppFilePath);
      });

      test(
          'when called with custom test_helpers file path should return full test_helpers file path from config',
          () async {
        final path = 'test/helpers/test_helpers.dart';
        getAndRegisterMockFileService(readFileResult: customConfig);
        final service = _getService();
        await service.loadConfig();
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, isNot(path));
        expect(customPath, testHelpersFilePath);
      });
    });

    group('getImportPath -', () {
      test(
          'when called with path equals "lib/src/services" should return "src/services"',
          () async {
        final path = 'lib/src/services';
        final service = _getService();
        final importPath = service.getImportPath(path);
        expect(importPath, 'src/services');
      });

      test(
          'when called with path equals "src/lib/services" should return "src/lib/services"',
          () async {
        final path = 'src/lib/services';
        final service = _getService();
        final importPath = service.getImportPath(path);
        expect(importPath, path);
      });

      test(
          'when called with path equals "src/services" should return "src/services"',
          () async {
        final path = 'src/services';
        final service = _getService();
        final importPath = service.getImportPath(path);
        expect(importPath, path);
      });
    });

    group('getRelativePathToHelpersAndMocks -', () {
      test(
          'when called with path equals "test/service_tests" should return "../../test/helpers/test_helpers.dart"',
          () async {
        final path = 'test/service_tests';
        final service = _getService();
        final importPath = service.getRelativePathToHelpersAndMocks(path);
        expect(importPath, '../../test/helpers/test_helpers.dart');
      });

      test(
          'when called with path equals "test/service_test" should return "../../test/helpers/test_helpers.dart"',
          () async {
        final path = 'test/service_test';
        final service = _getService();
        final importPath = service.getRelativePathToHelpersAndMocks(path);
        expect(importPath, '../../test/helpers/test_helpers.dart');
      });
    });
  });
}
