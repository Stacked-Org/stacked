import 'package:build_test/build_test.dart';
import 'package:stacked_localisation_generator/src/localisation_string_key_generator.dart';
import 'package:test/test.dart';

void main() {
  group('LocalisationStringKeyGeneratorTest -', () {
    group('Assets -', () {
      test(
          'When given a JSON file, should generate a class called HomeViewStrings',
          () async {
        await testBuilder(LocalisationStringKeyGenerator(), {
          'a|assets/lang/en.json': r'''
{
  "HomeView": {
    "title": "This is my Home",
    "subtitle": "I live in this Home"
  }
}'''
        }, outputs: {
          'a|lib/localisation_string_keys.dart': r'''
/// This code is generated. DO NOT edit by hand


class HomeViewStrings {
  static String title = 'HomeView.title';
  static String subtitle = 'HomeView.subtitle';
}
'''
        });
      });

      test(
          'When given a YAML file, should generate a class called HomeViewStrings',
          () async {
        await testBuilder(LocalisationStringKeyGenerator(), {
          'a|assets/lang/en.yaml': r'''
HomeView:
  title: This is my Home
  subtitle: I live in this Home
'''
        }, outputs: {
          'a|lib/localisation_string_keys.dart': r'''
/// This code is generated. DO NOT edit by hand


class HomeViewStrings {
  static String title = 'HomeView.title';
  static String subtitle = 'HomeView.subtitle';
}
'''
        });
      });
    });
  });
}
