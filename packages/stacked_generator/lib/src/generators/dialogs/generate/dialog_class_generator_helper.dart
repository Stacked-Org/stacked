import 'package:stacked_generator/src/generators/base_generator.dart';

import '../dialog_config.dart';
import 'dialog_class_content.dart';

mixin DialogClassGeneratorHelper on BaseGenerator {
  void writeDialogTypeEnum(List<DialogConfig> dialogConfigs) {
    writeLine("enum DialogType{");
    for (var dialogConfig in dialogConfigs) {
      writeLine(dialogConfig.dialogClassName + ',');
    }
    writeLine("}");
  }

  void writeDialogHeader(String? locatorName) {
    write(setupDialogHeader(locatorName));
  }

  void writeStackedservicesAndGeneratedLocaterImports() {
    writeLine();
    writeLine("import 'package:stacked_services/stacked_services.dart';");
    writeLine("import 'app.locator.dart';");
    writeLine();
  }

  void writeDialogsImports(List<DialogConfig> dialogConfigs) {
    final imports = dialogConfigs.fold<Set<String>>(
        {}, (previousValue, element) => {...previousValue, element.import});
    sortAndGenerate(imports);
    writeLine();
  }

  void writeDialogsRegistrationEntries(List<DialogConfig> dialogConfigs) {
    for (var dialogConfig in dialogConfigs) {
      write(dialogRegisterContent(dialogConfig.dialogClassName));
    }
  }
}
