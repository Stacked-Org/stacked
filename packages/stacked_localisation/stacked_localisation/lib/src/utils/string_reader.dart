import 'package:flutter/services.dart';
import 'dart:convert';

import 'map_helpers.dart';

/// Gets the strings for the locale from the source requested from
class StringReader {
  /// Reads the strings from the app bundle in location assets/lang/{locale}.json
  /// and returns the json as a String map.
  Future<Map<String, String>> getStringsFromAssets(String locale) async {
    // Read the strings from disk
    String stringContent;

    try {
      stringContent = await rootBundle.loadString('assets/lang/$locale.json');
    } catch (_) {
      var majorOnly = locale.split('_').first;
      stringContent =
          await rootBundle.loadString('assets/lang/$majorOnly.json');
    }

    var flattenedMap = flattenMap(json.decode(stringContent));
    return flattenedMap;
  }
}
