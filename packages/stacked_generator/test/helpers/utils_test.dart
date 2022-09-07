import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';
import 'package:test/test.dart';

void main() {
  group('UtilsTest -', () {
    test(
        'Detect if the type is a DataStructure such as List<String> and splite on the first arrow',
        () {
      expect('List<String>'.getTypeInsideList!.group(2), 'String');
    });
  });
}
