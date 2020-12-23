class CustomSnackbarException implements Exception {
  final String message;
  CustomSnackbarException(this.message);

  @override
  String toString() {
    return 'CustomSnackbarException: $message';
  }
}
