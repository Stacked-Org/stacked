import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_parameter_config.dart';

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

List<ParamConfig> notQueryNorPath(List<ParamConfig> parameters) {
  return parameters.where((p) {
    return !p.isPathParam && !p.isQueryParam;
  }).toList();
}

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

String valueOr(String? value, String or) {
  return value == null || value.isEmpty ? or : value;
}

extension IterableExtenstion<E> on Iterable<E> {
  E? firstOrNull(bool Function(E element) test) {
    for (var e in this) {
      if (test(e)) {
        return e;
      }
    }
    return null;
  }

  E? lastOrNull(bool Function(E element) test) {
    for (var i = length - 1; i >= 0; i--) {
      if (test(elementAt(i))) {
        return elementAt(i);
      }
    }
    return null;
  }

  Iterable<E> distinctBy<T>(T Function(E e) distinctBy) {
    final uniqueItems = <T, E>{};
    for (var e in this) {
      uniqueItems[distinctBy(e)] = e;
    }
    return uniqueItems.values;
  }
}
