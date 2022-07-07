/// Provides functionality common to all Generators
abstract class BaseGenerator {
  String generate();
}

mixin StringBufferUtils {
  final StringBuffer _stringBuffer = StringBuffer();
  String get serializeStringBuffer {
    return _stringBuffer.toString();
  }

  /// Writes the object supplied next to what was written before without adding a new line
  void write(Object obj) => _stringBuffer.write(obj);

  /// Writes a line of text into the current [StringBuffer] and adds a space new line after it
  void writeLine([Object obj = '']) => _stringBuffer.writeln(obj);

  /// Adds a new line after what was written before this
  void newLine() => _stringBuffer.writeln();

  /// Sorts the imports and then writed it to the current [StringBuffer]
  void sortAndGenerate(Iterable<String> imports) {
    var sorted = imports.toList()..sort();
    sorted.forEach((import) => writeLine("import '$import';"));
  }

  void generateAndAddNewLines(Iterable<String> imports,
      {int preLines = 0, int postlines = 0}) {
    List.generate(preLines, (_) => writeLine());
    imports.forEach((import) => writeLine("import '$import';"));
    List.generate(postlines, (_) => writeLine());
  }
}

  // void sortAndGenerate(Set<String> imports, {bool withAlias = false}) {
  //   var sorted = imports.toList()..sort();

  //   if (withAlias) {
  //     sorted.asMap().forEach(
  //         (index, import) => writeLine("import '$import' as i_$index;"));
  //   } else {
  //     sorted.forEach((import) => writeLine("import '$import';"));
  //   }
  // }