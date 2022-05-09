import 'package:get_it/get_it.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/services/path_service.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:stacked_tools/src/services/pubspec_service.dart';
import 'package:stacked_tools/src/services/template_service.dart';
import 'package:stacked_tools/src/templates/template_helper.dart';

final locator = GetIt.I;

Future setupLocator() async {
  locator.registerLazySingleton(() => ColorizedLogService()); 
  locator.registerLazySingleton(() => PubspecService());
  locator.registerLazySingleton(() => PathService());
  locator.registerLazySingleton(() => TemplateService());
  locator.registerLazySingleton(() => FileService());
  locator.registerLazySingleton(() => TemplateHelper());
  locator.registerLazySingleton(() => ProcessService());
}
