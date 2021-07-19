class OverlayRequest<T> {
  /// The title for the dialog
  final String? title;

  /// Text so show in the dialog body
  final String? description;

  /// Indicates if an image should be used or not
  final bool? hasImage;

  /// The url / path to the image to show
  final String? imageUrl;

  /// The text shown in the main button
  final String? mainButtonTitle;

  /// A bool to indicate if you should show an icon in the main button
  final bool? showIconInMainButton;

  /// The text to show on the secondary button on the dialog (cancel usually)
  final String? secondaryButtonTitle;

  /// Indicates if you should show an icon in the main button
  final bool? showIconInSecondaryButton;

  /// The text show on the third button on the dialog
  final String? additionalButtonTitle;

  /// Indicates if you should show an icon in the additional button
  final bool? showIconInAdditionalButton;

  /// Indicates if the dialog takes input
  final bool? takesInput;

  /// Intended to be used with enums. If you want to create multiple different
  /// dialogs. Pass your enum in here and check the value in the builder
  final dynamic variant;

  /// Extra data to be passed to the UI
  final dynamic customData;

  /// Extra data to be passed to the UI
  final T? data;

  OverlayRequest({
    this.showIconInMainButton,
    this.showIconInSecondaryButton,
    this.showIconInAdditionalButton,
    this.title,
    this.description,
    this.hasImage,
    this.imageUrl,
    this.mainButtonTitle,
    this.secondaryButtonTitle,
    this.additionalButtonTitle,
    this.takesInput,
    @Deprecated('Prefer to use `data` and pass in a generic type.')
        this.customData,
    this.data,
    this.variant,
  });
}

class DialogRequest<T> extends OverlayRequest<T> {
  DialogRequest({
    bool? showIconInMainButton,
    bool? showIconInSecondaryButton,
    bool? showIconInAdditionalButton,
    String? title,
    String? description,
    bool? hasImage,
    String? imageUrl,
    String? mainButtonTitle,
    String? secondaryButtonTitle,
    String? additionalButtonTitle,
    bool? takesInput,
    @Deprecated('Prefer to use `data` and pass in a generic type.')
        dynamic customData,
    T? data,
    dynamic variant,
  }) : super(
          additionalButtonTitle: additionalButtonTitle,
          customData: customData,
          description: description,
          hasImage: hasImage,
          imageUrl: imageUrl,
          mainButtonTitle: mainButtonTitle,
          secondaryButtonTitle: secondaryButtonTitle,
          showIconInAdditionalButton: showIconInAdditionalButton,
          showIconInMainButton: showIconInMainButton,
          showIconInSecondaryButton: showIconInSecondaryButton,
          takesInput: takesInput,
          title: title,
          data: data,
          variant: variant,
        );
}

class SheetRequest<T> extends OverlayRequest<T> {
  SheetRequest({
    bool? showIconInMainButton,
    bool? showIconInSecondaryButton,
    bool? showIconInAdditionalButton,
    String? title,
    String? description,
    bool? hasImage,
    String? imageUrl,
    String? mainButtonTitle,
    String? secondaryButtonTitle,
    String? additionalButtonTitle,
    bool? takesInput,
    @Deprecated('Prefer to use `data` and pass in a generic type.')
        dynamic customData,
    T? data,
    dynamic variant,
  }) : super(
          additionalButtonTitle: additionalButtonTitle,
          customData: customData,
          description: description,
          hasImage: hasImage,
          imageUrl: imageUrl,
          mainButtonTitle: mainButtonTitle,
          secondaryButtonTitle: secondaryButtonTitle,
          showIconInAdditionalButton: showIconInAdditionalButton,
          showIconInMainButton: showIconInMainButton,
          showIconInSecondaryButton: showIconInSecondaryButton,
          takesInput: takesInput,
          title: title,
          variant: variant,
          data: data,
        );
}
