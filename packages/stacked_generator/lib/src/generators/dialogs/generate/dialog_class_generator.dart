import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/dialogs/dialog_config.dart';
import 'package:stacked_generator/src/generators/dialogs/generate/dialog_class_generator_helper.dart';

import 'dialog_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class DialogClassGenerator extends BaseGenerator
    with DialogClassGeneratorHelper {
  final List<DialogConfig> dialogConfigs;

  DialogClassGenerator(this.dialogConfigs);

  @override
  String generate() {
    writeStackedservicesAndGeneratedLocaterImports();

    writeDialogsImports(dialogConfigs);

    writeDialogTypeEnum(dialogConfigs);

    write(setupDialogHeader);

    writeDialogsRegistrationEntries(dialogConfigs);

    write(dialogRegisterTrailing);

    return serializeStringBuffer;
  }
}
