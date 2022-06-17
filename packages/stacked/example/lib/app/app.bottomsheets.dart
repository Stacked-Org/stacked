// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/bottomsheets/generic_bottomsheet.dart';

enum BottomsheetType {
  genericBottomSheet,
}

void setupBottomsheetUi() {
  var bottomsheetService = exampleLocator<BottomSheetService>();

  final builders = {
    BottomsheetType.genericBottomSheet: (context, SheetRequest request,
            void Function(SheetResponse) completer) =>
        GenericBottomSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
