import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/bottomsheets/bottomsheet_config.dart';

import 'bottomsheet_class_content.dart';

class BottomsheetClassGeneratorHelper with StringBufferUtils {
  void writeBottomsheetTypeEnum(List<BottomsheetConfig> bottomsheetConfigs) {
    writeLine("enum BottomSheetType{");
    for (var bottomsheetConfig in bottomsheetConfigs) {
      writeLine('${bottomsheetConfig.enumValue},');
    }
    writeLine('// @stacked-bottom-sheet-type');
    writeLine("}");
  }

  void writeBottomsheetHeader(String? locatorName) {
    write(setupBottomsheetHeader(locatorName));
  }

  void writeStackedservicesAndGeneratedLocaterImports() {
    writeLine();
    writeLine("import 'package:stacked_services/stacked_services.dart';");
    writeLine();
    writeLine("import 'app.locator.dart';");
  }

  void writeBottomsheetsImports(List<BottomsheetConfig> bottomsheetConfigs) {
    final imports = bottomsheetConfigs.fold<Set<String>>(
      {},
      (previousValue, element) => {...previousValue, element.import},
    );
    sortAndGenerate(imports);
    writeLine();
  }

  void writeBottomsheetsRegistrationEntries(
    List<BottomsheetConfig> bottomsheetConfigs,
  ) {
    for (var bottomsheetConfig in bottomsheetConfigs) {
      write(bottomsheetRegisterContent(
        bottomsheetConfig.bottomsheetClassName,
        bottomsheetConfig.enumValue,
      ));
    }
  }
}
