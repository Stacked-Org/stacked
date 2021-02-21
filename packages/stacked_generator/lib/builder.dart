import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/src/generators/getit/stacked_getit_generator.dart';

import 'src/generators/router/stacked_router_generator.dart';

Builder stackedRouterGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedRouterGenerator(),
    generatedExtension: '.router.dart',
  );
}

Builder stackedLocatorGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedGetItGenerator(),
    generatedExtension: '.locator.dart',
  );
}
