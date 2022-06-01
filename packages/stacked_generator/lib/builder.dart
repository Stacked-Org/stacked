import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/src/generators/forms/stacked_form_generator.dart';
import 'package:stacked_generator/src/generators/getit/stacked_locator_generator.dart';
import 'package:stacked_generator/src/generators/logging/stacked_logger_generator.dart';
import 'package:stacked_generator/src/generators/router/stacked_router_generator.dart';

import 'src/generators/dialogs/resolve/stacked_dialog_generator.dart';

Builder stackedRouterGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedRouterGenerator(),
    generatedExtension: '.router.dart',
  );
}

Builder stackedLocatorGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedLocatorGenerator(),
    generatedExtension: '.locator.dart',
  );
}

Builder stackedFormGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedFormGenerator(),
    generatedExtension: '.form.dart',
  );
}

Builder stackedLoggerGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedLoggerGenerator(),
    generatedExtension: '.logger.dart',
  );
}

Builder stackedDialogGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedDialogGenerator(),
    generatedExtension: '.dialog.dart',
  );
}
