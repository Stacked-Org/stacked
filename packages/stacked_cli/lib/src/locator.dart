import 'package:get_it/get_it.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/path_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_helper.dart';

final locator = GetIt.I;

Future setupLocator() async {
  final pubSpecService = PubspecService();
  await pubSpecService.initialise();
  locator.registerSingleton(pubSpecService);

  locator.registerLazySingleton(() => PathService());
  locator.registerLazySingleton(() => TemplateService());
  locator.registerLazySingleton(() => FileService());
  locator.registerLazySingleton(() => TemplateHelper());
}
