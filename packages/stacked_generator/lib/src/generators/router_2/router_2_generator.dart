import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';

class Router2Generator implements BaseGenerator {
  Router2Generator();

  /// Where we store the result of [_generateClasses]
  List<Spec> classes = [];
  List<String> notAliasedImports = [];
  @override
  String generate() {
    return '// This is the second router';
  }
}
