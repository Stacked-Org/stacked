import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

String setupBottomsheetHeader(String? locatorName) => '''
void setupBottomsheetUi() {
  var bottomsheetService = ${locatorName ?? 'locator'}<BottomSheetService>();

  final builders = {
  
''';

String bottomsheetRegisterContent(String bottomsheetClassName) => '''
  BottomsheetType.${bottomsheetClassName.toLowerCamelCase}: (context, SheetRequest request, void Function(SheetResponse) completer) =>
        $bottomsheetClassName(request: request,completer: completer),
''';

const bottomsheetRegisterTrailing = '''
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
