import 'package:stacked_generator/src/generators/base_generator.dart';

import '../../../../utils.dart';
import '../bottomsheet_config.dart';
import 'bottomsheet_class_content.dart';

class BottomsheetClassGeneratorHelper with StringBufferUtils {
  void writeBottomsheetTypeEnum(List<BottomsheetConfig> bottomsheetConfigs) {
    writeLine("enum BottomsheetType{");
    for (var bottomsheetConfig in bottomsheetConfigs) {
      writeLine(toLowerCamelCase(bottomsheetConfig.bottomsheetClassName) + ',');
    }
    writeLine("}");
  }

  void writeBottomsheetHeader(String? locatorName) {
    write(setupBottomsheetHeader(locatorName));
  }

  void writeStackedservicesAndGeneratedLocaterImports() {
    writeLine();
    writeLine("import 'package:stacked_services/stacked_services.dart';");
    writeLine("import 'app.locator.dart';");
    writeLine();
  }

  void writeBottomsheetsImports(List<BottomsheetConfig> bottomsheetConfigs) {
    final imports = bottomsheetConfigs.fold<Set<String>>(
        {}, (previousValue, element) => {...previousValue, element.import});
    sortAndGenerate(imports);
    writeLine();
  }

  void writeBottomsheetsRegistrationEntries(
      List<BottomsheetConfig> bottomsheetConfigs) {
    for (var bottomsheetConfig in bottomsheetConfigs) {
      write(bottomsheetRegisterContent(bottomsheetConfig.bottomsheetClassName));
    }
  }
}
