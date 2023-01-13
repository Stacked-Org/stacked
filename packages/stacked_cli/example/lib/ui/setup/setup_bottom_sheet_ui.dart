import 'package:flutter/material.dart';
import 'package:example/app/app.locator.dart';
import 'package:example/enums/bottom_sheet_type.dart';
import 'package:example/ui/bottom_sheets/notice/notice_sheet.dart';
// @stacked-bottom-sheet-import
import 'package:stacked_services/stacked_services.dart';

typedef BottomSheetBuilder = Widget Function(
  BuildContext context,
  SheetRequest<dynamic> sheetRequest,
  void Function(SheetResponse<dynamic> sheetResponse) completer,
);

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final Map<dynamic, BottomSheetBuilder> builders = {
    BottomSheetType.notice: (context, sheetRequest, completer) =>
        NoticeSheet(completer: completer, request: sheetRequest),
    // @stacked-bottom-sheet-builder
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
