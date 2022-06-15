import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';

String toLowerCamelCase(String s) {
  if (s.length < 2) return s.toLowerCase();
  return s[0].toLowerCase() + s.substring(1);
}

String capitalize(String s) {
  if (s.length < 2) return s.toUpperCase();
  return s[0].toUpperCase() + s.substring(1);
}

String toKababCase(String s) {
  return s.replaceAllMapped(RegExp('(.+?)([A-Z])'),
      (match) => '${match.group(1)}-${match.group(2)}'.toLowerCase());
}

String toDisplayString(DartType e, {bool withNullability = false}) {
  return e.getDisplayString(withNullability: withNullability);
}

String processedReturnType(String? returnType) {
  final returnTypeContainsBiggerOperatorWithOneOfRouteNames =
      returnType != null &&
          returnType.contains('<') &&
          returnType.contains(
              RegExp('CustomRoute|MaterialRoute|CupertinoRoute|AdaptiveRoute'));

  if (returnTypeContainsBiggerOperatorWithOneOfRouteNames) {
    final afterRemovingArrowHeads = returnType.substring(
        returnType.indexOf('<') + 1, returnType.lastIndexOf('>'));

    return afterRemovingArrowHeads;
  } else {
    return returnType ?? 'dynamic';
  }
}

void throwIf(bool condition, String message,
    {Element? element, String todo = ''}) {
  if (condition) {
    throwError(message, todo: todo, element: element);
  }
}

void throwError(String message, {Element? element, String todo = ''}) {
  throw InvalidGeneratorInputException(
    message,
    todo: todo,
    element: element,
  );
}
