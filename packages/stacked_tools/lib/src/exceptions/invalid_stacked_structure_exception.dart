class InvalidStackedStructureException implements Exception {
  final String message;
  InvalidStackedStructureException(this.message);

  @override
  String toString() {
    return message;
  }
}
