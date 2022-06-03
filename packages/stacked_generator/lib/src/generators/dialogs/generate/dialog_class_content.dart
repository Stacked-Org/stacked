String setupDialogHeader(String? locatorName) => '''
void setupDialogUi() {
  var dialogService = ${locatorName ?? 'locator'}<DialogService>();

  final builders = {
  
''';
String dialogRegisterContent(String dialogClassName) => '''
  DialogType.${dialogClassName}: (context, sheetRequest, completer) =>
        ${dialogClassName}(request: sheetRequest, completer: completer),
''';

const dialogRegisterTrailing = '''
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
