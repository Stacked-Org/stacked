const kBottomsheetsEmpty = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';


enum BottomsheetType{
}
void setupBottomsheetUi() {
  var bottomsheetService = locator<BottomSheetService>();

  final builders = {
  
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
const kBottomsheetsWithCustomNamedLocator = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';


enum BottomsheetType{
}
void setupBottomsheetUi() {
  var bottomsheetService = customLocator<BottomSheetService>();

  final builders = {
  
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
const kOneBottomsheet = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import 'one.dart';

enum BottomsheetType{
basicBottomsheet,
}
void setupBottomsheetUi() {
  var bottomsheetService = locator<BottomSheetService>();

  final builders = {
  
  BottomsheetType.basicBottomsheet: (context, SheetRequest request, void Function(SheetResponse) completer) =>
        BasicBottomsheet(request: request,completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
const kTwoBottomsheets = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import 'one.dart';
import 'two.dart';

enum BottomsheetType{
basicBottomsheet,
complexBottomsheet,
}
void setupBottomsheetUi() {
  var bottomsheetService = locator<BottomSheetService>();

  final builders = {
  
  BottomsheetType.basicBottomsheet: (context, SheetRequest request, void Function(SheetResponse) completer) =>
        BasicBottomsheet(request: request,completer: completer),
  BottomsheetType.complexBottomsheet: (context, SheetRequest request, void Function(SheetResponse) completer) =>
        ComplexBottomsheet(request: request,completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
