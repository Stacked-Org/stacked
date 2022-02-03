import 'package:get_it/get_it.dart';
import 'package:stacked_cli/src/services/file_service.dart';

final locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => FileService());
}
