import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import 'map_utils.dart';

class LocalisationStringKeyGenerator implements Builder {
  static final _allLanguageFiles = new Glob('assets/lang/*');

  static AssetId _stringKeysOutput(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', 'localisation_string_keys.dart'),
    );
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    await for (final input in buildStep.findAssets(_allLanguageFiles)) {
      var fileContent = await buildStep.readAsString(input);

      var languageStringsMap = loadYaml(fileContent) as Map<dynamic, dynamic>;

      var localisationstrings = getStringKeysCodeFromMap(languageStringsMap);

      // Bail out after the first file. We only need 1 language file to define all the keys since
      // it's expected that the language files will all contain the same keys.
      final outputFile = _stringKeysOutput(buildStep);
      return buildStep.writeAsString(outputFile, localisationstrings);

      // TODO: Throw an exception when the language files have different keys from one another
    }
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': const ['localisation_string_keys.dart'],
    };
  }
}
