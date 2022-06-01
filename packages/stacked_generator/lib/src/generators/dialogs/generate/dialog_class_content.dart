const setupDialogHeader = '''
void setupDialogUi() {
  var dialogService = locator<DialogService>();

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
