import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_localisation/src/utils/map_helpers.dart';

void main() {
  group('MapHelpersTest -', () {
    group('flattenMap -', () {
      test(
          'Given map with 1 level deep map nesting, should combine key for that map',
          () {
        final parentKey = 'Home';
        final childKey = 'title';
        Map<String, dynamic> oneLevelDeepMap = {
          parentKey: {childKey: 'This is a title'}
        };

        var flattenedMap = flattenMap(oneLevelDeepMap);
        expect(flattenedMap.containsKey('$parentKey.$childKey'), true);
      });

      test(
          'Given map with 1 level deep map nesting, should store "This is a title" in Home.title key',
          () {
        final parentKey = 'Home';
        final childKey = 'title';
        final childValue = 'This is a title';
        Map<String, dynamic> oneLevelDeepMap = {
          parentKey: {childKey: childValue}
        };

        var flattenedMap = flattenMap(oneLevelDeepMap);
        expect(flattenedMap['$parentKey.$childKey'], childValue);
      });

      test(
          'Given map with root child that contains a map with 2 children should have 2 keys in flattened map',
          () {
        Map<String, dynamic> oneLevelDeepMap = {
          'Home': {
            'title': 'This is a title',
            'subtitle': 'subtitles are for losers'
          }
        };

        var flattenedMap = flattenMap(oneLevelDeepMap);
        expect(flattenedMap.keys.length, 2);
      });
    });
  });
}
