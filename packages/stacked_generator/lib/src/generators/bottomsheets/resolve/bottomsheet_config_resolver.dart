import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/bottomsheets/bottomsheet_config.dart';

import '../../../../utils.dart';

/// Reolves the [BottomsheetConfig] and returns the object if it's supplied
class BottomsheetConfigResolver {
  List<BottomsheetConfig> resolve(
      List<DartObject>? bottomsheetsObject, ImportResolver importResolver) {
    final bottomSheetConfig = <BottomsheetConfig>[];

    // Convert the bottomsheet config into BottomsheetConfig
    for (final bottomsheetObject in bottomsheetsObject!) {
      var bottomsheetReader = ConstantReader(bottomsheetObject);

      // Get the type of the bottomsheet that we want to register
      final bottomsheetClassType =
          bottomsheetReader.read('classType').typeValue;

      final classElement = bottomsheetClassType.element2 as ClassElement?;

      // Get the import of the class type that's defined for the bottomSheet
      final import = importResolver.resolve(classElement!);

      final className = toDisplayString(bottomsheetClassType);

      bottomSheetConfig.add(BottomsheetConfig(
          bottomsheetClassName: className, import: import ?? ''));
    }

    return bottomSheetConfig;
  }
}
