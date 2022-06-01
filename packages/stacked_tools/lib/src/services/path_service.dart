import 'dart:io';

import 'package:path/path.dart' as p;

/// Wraps the path package functionality to allow us to write
/// deterministic unit tests when using path related functionality
class PathService {
  String get templatesPath => p.joinAll([
        Directory.current.path,
        'lib',
        'src',
        'templates',
      ]);

  String get separator => p.separator;

  String join(String part1,
          [String? part2,
          String? part3,
          String? part4,
          String? part5,
          String? part6,
          String? part7,
          String? part8]) =>
      p.join(
        part1,
        part2,
        part3,
        part4,
        part5,
        part6,
        part7,
        part8,
      );

  String basename(String path) => p.basename(path);
}
