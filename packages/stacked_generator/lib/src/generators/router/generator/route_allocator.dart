import 'package:code_builder/code_builder.dart';

/// Add This Word To The End Of Any Import To UnAlias It
const kFlagToPreventAliasingTheImport = '#EXCLUDE';

class RouteAllocator implements Allocator {
  final _doNotPrefix = ['dart:core'];

  final _doNotPrefixImports = <String>{};
  final _imports = <String, int>{};
  var _keys = 1;

  @override
  String allocate(Reference reference) {
    final symbol = reference.symbol;
    final url = reference.url;
    if (url == null || _doNotPrefix.contains(url)) {
      return symbol!;
    }
    if (reference.url!.endsWith(kFlagToPreventAliasingTheImport)) {
      _doNotPrefixImports
          .add(reference.url!.replaceAll(kFlagToPreventAliasingTheImport, ''));
      return symbol!;
    }

    return '_i${_imports.putIfAbsent(url, _nextKey)}.$symbol';
  }

  int _nextKey() => _keys++;

  @override
  Iterable<Directive> get imports => _imports.keys
      .map(
        (u) => Directive.import(u, as: '_i${_imports[u]}'),
      )
      .followedBy(_doNotPrefixImports.map((e) => Directive.import(e)));
}
