import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/bottomsheets/bottomsheet_config.dart';
import 'package:stacked_generator/src/generators/bottomsheets/generate/bottomsheet_class_generator_helper.dart';

import 'bottomsheet_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class BottomsheetClassGenerator extends BottomsheetClassGeneratorHelper
    implements BaseGenerator {
  final List<BottomsheetConfig> bottomsheetConfigs;
  final String? locatorName;
  BottomsheetClassGenerator(this.bottomsheetConfigs, {this.locatorName});

  @override
  String generate() {
    writeStackedservicesAndGeneratedLocaterImports();

    writeBottomsheetsImports(bottomsheetConfigs);

    writeBottomsheetTypeEnum(bottomsheetConfigs);

    writeBottomsheetHeader(locatorName);

    writeBottomsheetsRegistrationEntries(bottomsheetConfigs);

    write(bottomsheetRegisterTrailing);

    return serializeStringBuffer;
  }
}
