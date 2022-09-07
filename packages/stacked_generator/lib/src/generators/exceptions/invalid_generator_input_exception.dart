import 'package:analyzer/dart/element/element.dart';

class InvalidGeneratorInputException implements Exception {
  final String message;
  final String? todo;
  final Element? element;
  const InvalidGeneratorInputException(this.message, {this.todo, this.element});

  @override
  String toString() =>
      'InvalidGeneratorInputException: message: $message\n todo: $todo\n element: $element';
}

class ExceptionMessages {
  static const routeClassNameShouldnotBeNull = 'className should not be null';

  static String isPathParamAndIsQueryParamShouldNotBeNull =
      'isPathParamAndIsQueryParamShouldNotBeNull';
}
