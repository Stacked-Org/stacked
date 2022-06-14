/// Described the Dialog functionality to generate in the app
class StackedDialog {
  /// Pass Dialogs types here.
  ///
  /// dialogs classes should have two named parameters:
  /// 1. request of type [DialogRequest]
  /// 2. completer of type [void Function(DialogResponse)]
  final Type classType;

  const StackedDialog({
    required this.classType,
  });
}
