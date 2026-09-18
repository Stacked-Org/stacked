import 'package:stacked/src/view_models/helpers/busy_error_state_helper.dart';

/// Helper class to store a data object
mixin DataStateHelper<T> on BusyAndErrorStateHelper {
  T? _data;

  T? get data => _data;

  set data(T? data) {
    _data = data;
  }

  /// Data is ready to be consumed
  bool get dataReady => _data != null && !hasError && !isBusy;

  /// Non-null [data]. Throws a [StateError] if [dataReady] is false.
  T get safeData {
    if (!dataReady) {
      throw StateError(
        'safeData was accessed while dataReady is false. '
        'Check dataReady (or isBusy/hasError) before accessing safeData.',
      );
    }

    return data as T;
  }
}
