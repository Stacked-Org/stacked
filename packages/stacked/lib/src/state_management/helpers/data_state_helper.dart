import 'package:stacked/src/state_management/helpers/busy_state_helper.dart';
import 'package:stacked/src/state_management/helpers/error_state_helper.dart';

/// Helper class to store a data object
mixin DataStateHelper<T> on ErrorStateHelper, BusyStateHelper {
  T? _data;

  T? get data => _data;

  set data(T? data) {
    _data = data;
  }

  /// Data is ready to be consumed
  bool get dataReady => _data != null && !hasError && !isBusy;
}
