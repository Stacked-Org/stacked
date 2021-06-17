class OverlayResponse<T> {
  /// Indicates if a show confirmation call has been confirmed or rejected.
  /// null will be returned when it's not a confirmation dialog.
  final bool confirmed;

  /// A place to put any response data from dialogs that may contain text fields
  /// or multi selection options
  @Deprecated('Use `data` and pass in a generic type.')
  final dynamic responseData;

  /// A place to put any response data from dialogs that may contain text fields
  /// or multi selection options
  final T? data;

  OverlayResponse({
    this.confirmed = false,
    this.responseData,
    this.data,
  });
}

/// The response returned from awaiting a call on the [DialogService]
class DialogResponse<T> extends OverlayResponse<T> {
  DialogResponse({
    bool confirmed = false,
    dynamic responseData,
    T? data,
  }) : super(
          confirmed: confirmed,
          responseData: responseData,
          data: data,
        );
}

/// The response returned from awaiting a call on the [BottomSheetService]
class SheetResponse<T> extends OverlayResponse<T> {
  SheetResponse({
    bool confirmed = false,
    dynamic responseData,
    T? data,
  }) : super(
          confirmed: confirmed,
          responseData: responseData,
          data: data,
        );
}
