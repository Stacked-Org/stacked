class OverlayResponse {
  /// Indicates if a show confirmation call has been confirmed or rejected.
  /// null will be returned when it's not a confirmation dialog.
  final bool confirmed;

  /// A place to put any response data from dialogs that may contain text fields
  /// or multi selection options
  final dynamic responseData;

  OverlayResponse({
    this.confirmed = false,
    this.responseData,
  });
}

/// The response returned from awaiting a call on the [DialogService]
class DialogResponse extends OverlayResponse {
  DialogResponse({
    bool confirmed = false,
    dynamic responseData,
  }) : super(
          confirmed: confirmed,
          responseData: responseData,
        );
}

/// The response returned from awaiting a call on the [BottomSheetService]
class SheetResponse extends OverlayResponse {
  SheetResponse({
    bool confirmed = false,
    dynamic responseData,
  }) : super(
          confirmed: confirmed,
          responseData: responseData,
        );
}
