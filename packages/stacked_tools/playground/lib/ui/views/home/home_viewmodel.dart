import 'package:stacked/stacked.dart';
import 'package:playground/app/app.locator.dart';
import 'package:playground/enums/bottom_sheet_type.dart';
import 'package:playground/enums/dialog_type.dart';
import 'package:playground/ui/common/app_strings.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Stacked Rocks!',
        description: 'Give stacked $_counter stars on Github ');
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
