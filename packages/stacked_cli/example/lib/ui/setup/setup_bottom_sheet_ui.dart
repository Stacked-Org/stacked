import 'package:example/app/app.locator.dart';
import 'package:example/enums/bottom_sheet_type.dart';
import 'package:example/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final Map<dynamic, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(completer: completer, request: request),
    // @stacked-bottom-sheet-builder
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
