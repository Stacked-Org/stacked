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

  /// Returns [data] without requiring the null-check operator (`!`).
  ///
  /// [data] is nullable because it starts out unset and can be cleared on
  /// error, so Dart can't promote it to a non-null type even after you've
  /// checked [dataReady]. This getter does that check for you: when
  /// [dataReady] is `true` it is safe to assume the underlying value is
  /// present, so it is returned as a non-null [T]. When [dataReady] is
  /// `false` (the future/stream hasn't completed yet, is busy, or has an
  /// error) it throws a descriptive [StateError] instead of returning a
  /// stale or missing value.
  ///
  /// Always check [dataReady] (or [isBusy] / [hasError]) before reading
  /// [safeData], for example:
  ///
  /// ```dart
  /// if (viewModel.dataReady) {
  ///   final value = viewModel.safeData; // No `!` needed here.
  /// }
  /// ```
  ///
  /// Note: because [dataReady] also requires the underlying value to be
  /// non-null, a [T] that is itself nullable (e.g. `String?`) can never be
  /// "ready" while its legitimate value is `null` - [dataReady] will be
  /// `false` and [safeData] will throw in that case.
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
