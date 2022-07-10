/// Described the Bottomsheet functionality to generate in the app
class StackedBottomsheet {
  /// Pass Bottomsheets types here.
  ///
  /// bottomsheets classes should have two named parameters:
  /// 1. request of type [BottomsheetRequest]
  /// 2. completer of type [void Function(BottomsheetResponse)]
  final Type classType;

  const StackedBottomsheet({
    required this.classType,
  });
}
