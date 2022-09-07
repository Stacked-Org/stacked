import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/models/config_model.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';
import 'package:stacked_tools/src/services/config_service.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/services/path_service.dart';
import 'package:stacked_tools/src/services/pubspec_service.dart';
import 'package:stacked_tools/src/services/template_service.dart';
import 'package:stacked_tools/src/templates/compiled_templates.dart';
import 'package:stacked_tools/src/templates/template_helper.dart';

// @stacked-import

import '../test_constants.dart';
import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  // core services
  MockSpec<FileService>(returnNullOnMissingStub: true),
  MockSpec<PathService>(returnNullOnMissingStub: true),
  MockSpec<TemplateService>(returnNullOnMissingStub: true),
  MockSpec<TemplateHelper>(returnNullOnMissingStub: true),
  MockSpec<PubspecService>(returnNullOnMissingStub: true),
  MockSpec<ColorizedLogService>(returnNullOnMissingStub: true),
  MockSpec<ConfigService>(returnNullOnMissingStub: true),
// @stacked-service-mock
])
MockFileService getAndRegisterMockFileService({
  bool fileExistsResult = true,
  String readFileResult = 'file_content',
  List<FileSystemEntity> getFilesInDirectoryResult = const [],
}) {
  _removeRegistrationIfExists<FileService>();
  final service = MockFileService();

  when(service.fileExists(filePath: anyNamed('filePath')))
      .thenAnswer((realInvocation) => Future.value(fileExistsResult));

  when(service.readFileAsString(filePath: anyNamed('filePath')))
      .thenAnswer((realInvocation) => Future.value(readFileResult));

  when(service.getFilesInDirectory(directoryPath: anyNamed('directoryPath')))
      .thenAnswer((realInvocation) => Future.value(getFilesInDirectoryResult));

  locator.registerSingleton<FileService>(service);
  return service;
}

MockPubspecService getAndRegisterPubSpecService({
  String packageName = 'stacked_tools',
}) {
  _removeRegistrationIfExists<PubspecService>();
  final service = MockPubspecService();
  when(service.getPackageName).thenReturn(packageName);
  locator.registerSingleton<PubspecService>(service);
  return service;
}

MockPathService getAndRegisterPathService({
  String templatesPathResult = 'template_path',
  String joinResult = 'joined_path',
}) {
  _removeRegistrationIfExists<PathService>();
  final service = MockPathService();

  when(service.join(
    any,
    any,
    any,
    any,
    any,
    any,
    any,
    any,
  )).thenReturn(joinResult);

  when(service.templatesPath).thenReturn(templatesPathResult);

  locator.registerSingleton<PathService>(service);
  return service;
}

MockTemplateHelper getAndRegisterTemplateHelper() {
  _removeRegistrationIfExists<TemplateHelper>();
  final service = MockTemplateHelper();
  locator.registerSingleton<TemplateHelper>(service);
  return service;
}

MockColorizedLogService getAndRegisterColorizedLogService() {
  _removeRegistrationIfExists<ColorizedLogService>();
  final service = MockColorizedLogService();
  locator.registerSingleton<ColorizedLogService>(service);
  return service;
}

MockConfigService getAndRegisterConfigService({
  String? customPath,
  String serviceImportPath = 'lib/services',
  String serviceTestHelpersImportPath = '../helpers/test_helpers.dart',
  String viewImportPath = 'lib/viewmodels',
  String viewTestHelpersImportPath = '../helpers/test_helpers.dart',
}) {
  _removeRegistrationIfExists<ConfigService>();
  final service = MockConfigService();

  when(service.serviceImportPath).thenReturn(serviceImportPath);
  when(service.serviceTestHelpersImportPath).thenReturn(
    serviceTestHelpersImportPath,
  );
  when(service.viewImportPath).thenReturn(viewImportPath);
  when(service.viewTestHelpersImportPath).thenReturn(viewTestHelpersImportPath);

  when(service.replaceCustomPaths(any)).thenAnswer(
    (invocation) => customPath ?? invocation.positionalArguments[0],
  );

  locator.registerSingleton<ConfigService>(service);
  return service;
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

// @stacked-mock-helper

void registerServices() {
  getAndRegisterMockFileService();
  getAndRegisterPathService();
  getAndRegisterTemplateHelper();
  getAndRegisterPubSpecService();
  getAndRegisterColorizedLogService();
  getAndRegisterConfigService();
// @stacked-mock-helper-register
}

void createTestFile(String template) {
  File(ksTestFileName).writeAsStringSync(template);
}

Future<void> deleteTestFile() async {
  File file = File(ksTestFileName);
  if (await file.exists()) {
    await file.delete();
  }
}
