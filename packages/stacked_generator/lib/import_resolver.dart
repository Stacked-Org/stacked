import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as p;

class ImportResolver {
  final List<LibraryElement> libs;
  final String targetFilePath;

  const ImportResolver(this.libs, this.targetFilePath);

  String? resolve(Element? element) {
    // return early if source is null or element is a core type
    if (element?.source == null || _isCoreDartType(element)) {
      return null;
    }

    for (var lib in libs) {
      if (_isCoreDartType(lib)) continue;

      if (lib.exportNamespace.definedNames.keys.contains(element?.name)) {
        final package = lib.source.uri.pathSegments.first;
        if (targetFilePath.startsWith(RegExp('^$package/'))) {
          return p.posix
              .relative(element?.source?.uri.path ?? '', from: targetFilePath)
              .replaceFirst('../', '');
        } else {
          return element?.source?.uri.toString();
        }
      }
    }

    return null;
  }

  bool _isCoreDartType(Element? element) {
    return element?.source?.fullName == 'dart:core';
  }

  Set<String> resolveAll(DartType type) {
    final imports = <String>{};
    final resolvedValue = resolve(type.element);
    if (resolvedValue != null) {
      imports.add(resolvedValue);
    }
    imports.addAll(_checkForParameterizedTypes(type));
    return imports..removeWhere((element) => element == '');
  }

  Set<String> _checkForParameterizedTypes(DartType typeToCheck) {
    final imports = <String>{};
    if (typeToCheck is ParameterizedType) {
      for (DartType type in typeToCheck.typeArguments) {
        final resolvedValue = resolve(type.element);
        if (resolvedValue != null) {
          imports.add(resolvedValue);
        }
        imports.addAll(_checkForParameterizedTypes(type));
      }
    }
    return imports;
  }
}
