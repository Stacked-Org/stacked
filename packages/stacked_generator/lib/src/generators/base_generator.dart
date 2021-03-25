/// Provides functionality common to all Generators
class BaseGenerator {
  final StringBuffer stringBuffer = StringBuffer();

  /// Writes the object supplied next to what was written before without adding a new line
  void write(Object obj) => stringBuffer.write(obj);

  /// Writes a line of text into the current [StringBuffer] and adds a space new line after it
  void writeLine([Object obj = '']) => stringBuffer.writeln(obj);

  /// Adds a new line after what was written before this
  void newLine() => stringBuffer.writeln();

  /// Sorts the imports and then writed it to the current [StringBuffer]
  void sortAndGenerate(Set<String> imports) {
    var sorted = imports.toList()..sort();
    sorted.forEach((import) => writeLine("import '$import';"));
  }
}
