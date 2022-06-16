const kBottomsheetsEmpty = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';


enum BottomsheetType{
}
void setupBottomsheetUi() {
  var bottomsheetService = locator<BottomsheetService>();

  final builders = {
  
  };

  bottomsheetService.registerCustomBottomsheetBuilders(builders);
}
''';
const kBottomsheetsWithCustomNamedLocator = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';


enum BottomsheetType{
}
void setupBottomsheetUi() {
  var bottomsheetService = customLocator<BottomsheetService>();

  final builders = {
  
  };

  bottomsheetService.registerCustomBottomsheetBuilders(builders);
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
  var bottomsheetService = locator<BottomsheetService>();

  final builders = {
  
  BottomsheetType.basicBottomsheet: (context, BottomsheetRequest request, void Function(BottomsheetResponse) completer) =>
        BasicBottomsheet(request: request,completer: completer),
  };

  bottomsheetService.registerCustomBottomsheetBuilders(builders);
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
  var bottomsheetService = locator<BottomsheetService>();

  final builders = {
  
  BottomsheetType.basicBottomsheet: (context, BottomsheetRequest request, void Function(BottomsheetResponse) completer) =>
        BasicBottomsheet(request: request,completer: completer),
  BottomsheetType.complexBottomsheet: (context, BottomsheetRequest request, void Function(BottomsheetResponse) completer) =>
        ComplexBottomsheet(request: request,completer: completer),
  };

  bottomsheetService.registerCustomBottomsheetBuilders(builders);
}
''';
