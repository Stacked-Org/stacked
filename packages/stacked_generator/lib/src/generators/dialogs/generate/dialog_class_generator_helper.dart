import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/dialogs/dialog_config.dart';

import 'dialog_class_content.dart';

class DialogClassGeneratorHelper with StringBufferUtils {
  void writeDialogTypeEnum(List<DialogConfig> dialogConfigs) {
    writeLine("enum DialogType{");
    for (var dialogConfig in dialogConfigs) {
      writeLine('${dialogConfig.enumValue},');
    }
    writeLine("// @stacked-dialog-type");
    writeLine("}");
  }

  void writeDialogHeader(String? locatorName) {
    write(setupDialogHeader(locatorName));
  }

  void writeStackedservicesAndGeneratedLocaterImports() {
    writeLine();
    writeLine("import 'package:stacked_services/stacked_services.dart';");
    writeLine();
    writeLine("import 'app.locator.dart';");
  }

  void writeDialogsImports(List<DialogConfig> dialogConfigs) {
    final imports = dialogConfigs.fold<Set<String>>(
      {},
      (previousValue, element) => {...previousValue, element.import},
    );
    sortAndGenerate(imports);
    writeLine();
  }

  void writeDialogsRegistrationEntries(List<DialogConfig> dialogConfigs) {
    for (var dialogConfig in dialogConfigs) {
      write(dialogRegisterContent(
        dialogConfig.dialogClassName,
        dialogConfig.enumValue,
      ));
    }
  }
}
