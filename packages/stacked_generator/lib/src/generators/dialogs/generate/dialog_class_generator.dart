import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/dialogs/dialog_config.dart';
import 'package:stacked_generator/src/generators/dialogs/generate/dialog_class_generator_helper.dart';

import 'dialog_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class DialogClassGenerator extends DialogClassGeneratorHelper
    implements BaseGenerator {
  final List<DialogConfig> dialogConfigs;
  final String? locatorName;
  DialogClassGenerator(this.dialogConfigs, {this.locatorName});

  @override
  String generate() {
    writeStackedservicesAndGeneratedLocaterImports();

    writeDialogsImports(dialogConfigs);

    writeDialogTypeEnum(dialogConfigs);

    writeDialogHeader(locatorName);

    writeDialogsRegistrationEntries(dialogConfigs);

    write(dialogRegisterTrailing);

    return serializeStringBuffer;
  }
}
