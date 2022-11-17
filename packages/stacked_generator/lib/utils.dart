import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/router/models/route_parameter_config.dart';

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

List<RouteParamConfig> notQueryNorPath(List<RouteParamConfig> parameters) {
  return parameters.where((p) {
    throwIf(p.isPathParam == null || p.isQueryParam == null,
        ExceptionMessages.isPathParamAndIsQueryParamShouldNotBeNull);
    return !p.isPathParam! && !p.isQueryParam!;
  }).toList();
}
