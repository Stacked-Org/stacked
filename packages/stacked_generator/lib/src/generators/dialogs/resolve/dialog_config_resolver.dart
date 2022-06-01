import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import '../../../../utils.dart';
import '../dialog_config.dart';

/// Reolves the [LoggerConfig] and returns the object if it's supplied
class DialogConfigResolver {
  List<DialogConfig> resolve(
      ConstantReader stackedApp, ImportResolver importResolver) {
    final dialogsConfig = stackedApp.peek('dialogs')?.listValue;

    throwIf(
        dialogsConfig == null, 'Something went wrong with dialog generator');

    final dialogConfigs = <DialogConfig>[];

    // Convert the dialog config into DialogConfig
    for (final dialogConfig in dialogsConfig!) {
      var dialogReader = ConstantReader(dialogConfig);

      // Get the type of the dialog that we want to register
      final dialogClassType = dialogReader.read('classType').typeValue;

      final classElement = dialogClassType.element as ClassElement?;

      // Get the import of the class type that's defined for the dialog
      final import = importResolver.resolve(classElement!);

      final className = toDisplayString(dialogClassType);

      dialogConfigs
          .add(DialogConfig(dialogClassName: className, import: import ?? ''));
    }

    return dialogConfigs;
  }
}
