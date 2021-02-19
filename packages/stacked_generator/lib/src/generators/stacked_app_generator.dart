import 'dart:async';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_app/stacked_app_annotations.dart';
import 'package:stacked_generator/src/core/logger.dart';
import 'package:stacked_generator/src/generators/router_class_generator.dart';

import '../../import_resolver.dart';
import '../../route_config_resolver.dart';

class StackedAppGenerator implements Builder {
  static final _mainFiles = new Glob('lib/main?.dart');

  final log = getLogger('StackedAppGenerator');

  static AssetId _getAssetIdForFileName(BuildStep buildStep, String filenName) {
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', filenName),
    );
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    var libraryElements = await buildStep.resolver.libraries.toList();
    await for (final input in buildStep.findAssets(_mainFiles)) {
      log.d('Found main file ${input.path}');
    }

    // log.d('Found ${mainFiles.length} main files');

    for (var library in libraryElements) {
      final libraryReader = LibraryReader(library);
      final annotations =
          libraryReader.annotatedWith(TypeChecker.fromRuntime(StackedApp));
      if (annotations.isNotEmpty) {
        log.d('Found ${annotations.length} annotated elements.');
        final annotatedApp = annotations.first;
        var importResolver = ImportResolver(
          libraryElements,
          library.source.uri.path,
        );

        var routerResolver = RouterConfigResolver(importResolver);

        final routerConfig =
            await routerResolver.resolve(annotatedApp.annotation);
        final routerCode = RouterClassGenerator(routerConfig).generate();
        log.d('Generated Router code\n$routerCode');
        final routerOutputFile =
            _getAssetIdForFileName(buildStep, 'stacked_router.dart');

        await buildStep.writeAsString(routerOutputFile, routerCode);
        break;
      } else {
        log.d('No annotations on ${library.displayName}');
      }
    }
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': const ['stacked_router.dart'],
    };
  }
}
