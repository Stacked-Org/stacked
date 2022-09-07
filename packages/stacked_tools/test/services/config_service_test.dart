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

    const String customConfig = '''
      {
        "views_path": "lib/my/personal/path/to/views",
        "services_path": "lib/my/personal/path/to/services",
        "test_services_path": "test/my/personal/path/to/tests/service",
        "test_views_path": "test/my/personal/path/to/tests/viewmodel"
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
          'when called with path that does NOT start with "test/" should throw an Exception',
          () async {
        final path = 'lib/src/services';
        final service = _getService();
        expect(
          () => service.getRelativePathToHelpersAndMocks(path),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString() ==
                      'Exception: Any test file should be placed inside "test" folder on root of the project. Please, correct your test location.',
            ),
          ),
        );
      });

      test(
          'when called with path equals "src/lib/services" should return "../helpers"',
          () async {
        final path = 'test/services';
        final service = _getService();
        final importPath = service.getRelativePathToHelpersAndMocks(path);
        expect(importPath, '../helpers');
      });

      test(
          'when called with path equals "src/lib/services" should return "../../../helpers"',
          () async {
        final path = 'test/src/lib/services';
        final service = _getService();
        final importPath = service.getRelativePathToHelpersAndMocks(path);
        expect(importPath, '../../../helpers');
      });

      test(
          'when called with path equals "src/lib/services" should return "../../../../../../helpers"',
          () async {
        final path = 'test/my/personal/path/to/tests/service';
        final service = _getService();
        final importPath = service.getRelativePathToHelpersAndMocks(path);
        expect(importPath, '../../../../../../helpers');
      });
    });
  });
}
