const kBottomsheetsEmpty = '''

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

enum BottomSheetType{
}
void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
  
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
const kBottomsheetsWithCustomNamedLocator = '''

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

enum BottomSheetType{
}
void setupBottomSheetUi() {
  final bottomsheetService = customLocator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
  
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
const kOneBottomsheet = '''

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import 'one.dart';

enum BottomSheetType{
basicBottomsheet,
}
void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
  
  BottomSheetType.basicBottomsheet: (context, request, completer) =>
        BasicBottomsheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
const kTwoBottomsheets = '''

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import 'one.dart';
import 'two.dart';

enum BottomSheetType{
basicBottomsheet,
complexBottomsheet,
}
void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
  
  BottomSheetType.basicBottomsheet: (context, request, completer) =>
        BasicBottomsheet(request: request, completer: completer),
  BottomSheetType.complexBottomsheet: (context, request, completer) =>
        ComplexBottomsheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
''';
