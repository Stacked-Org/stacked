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
        "services_path": "my/personal/path/to/services",
        "views_path": "my/personal/path/to/views",
        "test_helpers_file_path": "$testHelpersFilePath",
        "test_services_path": "my/personal/path/to/tests/service",
        "test_views_path": "my/personal/path/to/tests/viewmodel",
        "locator_name": "locator",
        "register_mocks_function": "registerServices",
        "v1": false,
        "line_length": 80
      }
    ''';

    group('resolveConfigFile -', () {
      test(
          'when called with output path and config file is present on output path should call fileExists on fileService 1 times',
          () async {
        final fileService = getAndRegisterFileService();
        final service = _getService();
        await service.resolveConfigFile(path: 'output');
        verify(
          fileService.fileExists(filePath: anyNamed('filePath')),
        ).called(1);
      });

      test(
          'when called without output path and config file is present on current path should call fileExists on fileService 1 times',
          () async {
        final fileService = getAndRegisterFileService();
        final service = _getService();
        await service.resolveConfigFile();
        verify(
          fileService.fileExists(filePath: anyNamed('filePath')),
        ).called(1);
      });

      test(
          'when called without output path and config file is present on XDG_CONFIG_HOME path should call fileExists on fileService 2 times',
          () async {
        final fileService = getAndRegisterFileService(retryUntilFileExists: 1);
        final service = _getService();
        await service.resolveConfigFile();
        verify(
          fileService.fileExists(filePath: anyNamed('filePath')),
        ).called(2);
      });

      test(
          'when called without output path and config file is present on current path with deprecated filename should call fileExists on fileService 3 times',
          () async {
        final fileService = getAndRegisterFileService(retryUntilFileExists: 2);
        final service = _getService();
        await service.resolveConfigFile();
        verify(
          fileService.fileExists(filePath: anyNamed('filePath')),
        ).called(3);
      });

      test(
          'when called with output path and without config file should call fileExists on fileService 4 times',
          () async {
        final fileService = getAndRegisterFileService(fileExistsResult: false);
        final service = _getService();
        await service.resolveConfigFile(path: 'output');
        verify(
          fileService.fileExists(filePath: anyNamed('filePath')),
        ).called(4);
      });

      test(
          'when called with output path and without config file should call fileExists on fileService in priority order',
          () async {
        final fileService = getAndRegisterFileService(fileExistsResult: false);
        final service = _getService();
        await service.resolveConfigFile(path: 'output');
        verifyInOrder([
          fileService.fileExists(filePath: 'output/stacked.json'),
          fileService.fileExists(filePath: 'stacked.json'),
          fileService.fileExists(
            filePath: '/Users/filledstacks/.config/stacked/stacked.json',
          ),
          fileService.fileExists(filePath: 'stacked.config.json'),
        ]);
      });

      test(
          'when called with output path and without config file should call fileExists on fileService 3 times',
          () async {
        final fileService = getAndRegisterFileService(fileExistsResult: false);
        final service = _getService();
        await service.resolveConfigFile();
        verify(
          fileService.fileExists(filePath: anyNamed('filePath')),
        ).called(3);
      });

      test(
          'when called without output path and without config file should call fileExists on fileService in priority order',
          () async {
        final fileService = getAndRegisterFileService(fileExistsResult: false);
        final service = _getService();
        await service.resolveConfigFile();
        verifyInOrder([
          fileService.fileExists(filePath: 'stacked.json'),
          fileService.fileExists(
            filePath: '/Users/filledstacks/.config/stacked/stacked.json',
          ),
          fileService.fileExists(filePath: 'stacked.config.json'),
        ]);
      });
    });

    group('loadConfig -', () {
      test('when called, should call fileExists on FileService', () async {
        getAndRegisterFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig();
        verify(service.resolveConfigFile());
      });

      test(
          'when called with path, should call fileExists on FileService with path',
          () async {
        getAndRegisterFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig(path: 'example');
        verify(service.resolveConfigFile(path: 'example'));
      });

      test(
          'when called and config json is malformed, should write error to console',
          () async {
        getAndRegisterFileService();
        final log = getAndRegisterColorizedLogService();
        final service = _getService();
        await service.loadConfig();
        verify(log.warn(message: kConfigFileMalformed));
      });

      test(
          'when called and config file not available, should NOT call fileExists on FileService',
          () async {
        final fileService = getAndRegisterFileService(
          fileExistsResult: false,
        );
        final service = _getService();
        await service.loadConfig();
        verifyNever(
          fileService.readFileAsString(filePath: kConfigFileName),
        );
      });

      test(
          'when called and config file not available, should write error to console',
          () async {
        getAndRegisterFileService(fileExistsResult: false);
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
        getAndRegisterFileService(readFileResult: '{}');
        final service = _getService();
        await service.loadConfig();
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, path);
      });

      test('when called with custom config should return custom path',
          () async {
        final path = 'test/services/generic_service_test.dart.stk';
        getAndRegisterFileService(readFileResult: customConfig);
        final service = _getService();
        await service.loadConfig();
        final customPath = service.replaceCustomPaths(path);
        expect(customPath, isNot(path));
        expect(
          customPath,
          'my/personal/path/to/tests/service/generic_service_test.dart.stk',
        );
      });

      test(
          'when called with custom stacked app file path should return full stacked_app file path from config',
          () async {
        final path = 'lib/app/app.dart';
        getAndRegisterFileService(readFileResult: customConfig);
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
        getAndRegisterFileService(readFileResult: customConfig);
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
          'when called with path equals "test/service_tests" should return "../helpers/test_helpers.dart"',
          () async {
        final path = 'test/service_tests';
        final service = _getService();
        final importPath = service.getFilePathToHelpersAndMocks(path);
        expect(importPath, '../helpers/test_helpers.dart');
      });

      test(
          'when called with path equals "test/service_test" should return "../helpers/test_helpers.dart"',
          () async {
        final path = 'test/service_test';
        final service = _getService();
        final importPath = service.getFilePathToHelpersAndMocks(path);
        expect(importPath, '../helpers/test_helpers.dart');
      });
    });
  });
}
