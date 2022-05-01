import 'package:stacked/stacked.dart';
import 'package:stacked_app/app/app.locator.dart';
import 'package:stacked_app/enums/bottom_sheet_type.dart';
import 'package:stacked_app/enums/dialog_type.dart';
import 'package:stacked_app/ui/common/app_strings.dart';
import 'package:stacked_services/stacked_services.dart';

class GenericViewModel extends BaseViewModel {
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
      title: ksGenericBottomSheetTitle,
      description: ksGenericBottomSheetDescription,
    );
  }
}
