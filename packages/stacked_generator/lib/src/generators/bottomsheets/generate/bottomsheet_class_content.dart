String setupBottomsheetHeader(String? locatorName) => '''
void setupBottomSheetUi() {
  final bottomsheetService = ${locatorName ?? 'locator'}<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
  
''';

String bottomsheetRegisterContent(
  String bottomsheetClassName,
  String enumValue,
) =>
    '''
  BottomSheetType.$enumValue: (context, request, completer) =>
        $bottomsheetClassName(request: request,completer: completer),
''';

const bottomsheetRegisterTrailing = '''
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
