import '../../../../utils.dart';

String setupBottomsheetHeader(String? locatorName) => '''
void setupBottomsheetUi() {
  var bottomsheetService = ${locatorName ?? 'locator'}<BottomsheetService>();

  final builders = {
  
''';

String bottomsheetRegisterContent(String bottomsheetClassName) => '''
  BottomsheetType.${toLowerCamelCase(bottomsheetClassName)}: (context, BottomsheetRequest request, void Function(BottomsheetResponse) completer) =>
        ${bottomsheetClassName}(request: request,completer: completer),
''';

const bottomsheetRegisterTrailing = '''
  };

  bottomsheetService.registerCustomBottomsheetBuilders(builders);
}
''';
