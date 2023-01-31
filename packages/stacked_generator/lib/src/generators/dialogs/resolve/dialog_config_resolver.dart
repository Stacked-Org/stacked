import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/dialogs/dialog_config.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';
import 'package:stacked_generator/utils.dart';

/// Reolves the [LoggerConfig] and returns the object if it's supplied
class DialogConfigResolver {
  List<DialogConfig> resolve(
    List<DartObject>? dialogsObject,
    ImportResolver importResolver,
  ) {
    final dialogConfigs = <DialogConfig>[];

    // Convert the dialog config into DialogConfig
    for (final dialogObject in dialogsObject!) {
      var dialogReader = ConstantReader(dialogObject);

      // Get the type of the dialog that we want to register
      final dialogClassType = dialogReader.read('classType').typeValue;

      final classElement = dialogClassType.element as ClassElement?;

      // Get the import of the class type that's defined for the dialog
      final import = importResolver.resolve(classElement!);

      final className = toDisplayString(dialogClassType);

      dialogConfigs.add(DialogConfig(
        dialogClassName: className,
        import: import ?? '',
      ));
    }

    return dialogConfigs;
  }
}
