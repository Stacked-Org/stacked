import '../../../../utils.dart';

String setupBottomsheetHeader(String? locatorName) => '''
void setupBottomsheetUi() {
  var bottomsheetService = ${locatorName ?? 'locator'}<BottomSheetService>();

  final builders = {
  
''';

String bottomsheetRegisterContent(String bottomsheetClassName) => '''
  BottomsheetType.${toLowerCamelCase(bottomsheetClassName)}: (context, SheetRequest request, void Function(SheetResponse) completer) =>
        $bottomsheetClassName(request: request,completer: completer),
''';

const bottomsheetRegisterTrailing = '''
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
