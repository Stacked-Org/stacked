import 'package:stacked_localisation_generator/src/map_utils.dart';
import 'package:test/test.dart';

void main() {
  group('MapUtilsTest -', () {
    group('getStringKeysCodeFromMap -', () {
      test('When given an empty map should return generator comment only', () {
        Map<String, dynamic> testmap = {};
        var stringsCode = getStringKeysCodeFromMap(testmap);
        expect(stringsCode, '''
$GeneratorComment

''');
      });

      test(
          'When given map with key HomeView, should generate a class called HomeViewStrings',
          () {
        Map<String, dynamic> testmap = {'HomeView': {}};
        var stringsCode = getStringKeysCodeFromMap(testmap);
        expect(stringsCode, '''
$GeneratorComment

class HomeViewStrings {
}
''');
      });

      test(
          'When given map with key HomeView and internal keys, should generate a class called HomeViewStrings with properties matching keys from HomeView map',
          () {
        Map<String, dynamic> testmap = {
          'HomeView': {
            'title': 'This is my title',
            'subtitle': 'This is a subtitle',
          }
        };
        var stringsCode = getStringKeysCodeFromMap(testmap);
        expect(stringsCode, '''
$GeneratorComment

class HomeViewStrings {
  static String title = 'HomeView.title';
  static String subtitle = 'HomeView.subtitle';
}
''');
      });
    });
  });
}
