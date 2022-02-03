import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/file_service.dart';

import 'test_helper.mocks.dart';

@GenerateMocks([], customMocks: [
  // core services
  MockSpec<FileService>(returnNullOnMissingStub: true),
])
MockFileService getAndRegisterMockFileService({
  bool fileExistsResult = true,
  String readFileResult = 'file_content',
}) {
  _removeRegistrationIfExists<FileService>();
  final service = MockFileService();

  when(service.fileExists(filePath: anyNamed('filePath')))
      .thenAnswer((realInvocation) => Future.value(fileExistsResult));

  when(service.readFile(filePath: anyNamed('filePath')))
      .thenAnswer((realInvocation) => Future.value(readFileResult));

  locator.registerSingleton<FileService>(service);
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
}
