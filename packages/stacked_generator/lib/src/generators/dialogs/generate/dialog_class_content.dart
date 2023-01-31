String setupDialogHeader(String? locatorName) => '''
void setupDialogUi() {
  final dialogService = ${locatorName ?? 'locator'}<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
  
''';

String dialogRegisterContent(String dialogClassName, String enumValue) => '''
  DialogType.$enumValue: (context, request, completer) =>
        $dialogClassName(request: request, completer: completer),
''';

const dialogRegisterTrailing = '''
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
