import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/stacked_router_generator.dart';

Builder stackedRouterGenerator(BuilderOptions options) {
  return LibraryBuilder(
    StackedRouterGenerator(),
    generatedExtension: '.router.dart',
  );
}
