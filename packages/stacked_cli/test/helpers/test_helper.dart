import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_cli/services/firestore_service.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/path_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_helper.dart';

// @stacked-import

import 'test_helper.mocks.dart';

@GenerateMocks([], customMocks: [
  // core services
  MockSpec<FileService>(returnNullOnMissingStub: true),
  MockSpec<PathService>(returnNullOnMissingStub: true),
  MockSpec<TemplateService>(returnNullOnMissingStub: true),
  MockSpec<TemplateHelper>(returnNullOnMissingStub: true),
  MockSpec<FirestoreService>(returnNullOnMissingStub: true),
  MockSpec<PubspecService>(returnNullOnMissingStub: true),
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

  when(service.readFile(filePath: anyNamed('filePath')))
      .thenAnswer((realInvocation) => Future.value(readFileResult));

  when(service.getFilesInDirectory(directoryPath: anyNamed('directoryPath')))
      .thenAnswer((realInvocation) => Future.value(getFilesInDirectoryResult));

  locator.registerSingleton<FileService>(service);
  return service;
}

MockPubspecService getAndRegisterPubSpecService({
  String packageName = 'stacked_cli',
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

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerServices() {
  getAndRegisterMockFileService();
  getAndRegisterPathService();
  getAndRegisterTemplateHelper();
  getAndRegisterPubSpecService();
}
