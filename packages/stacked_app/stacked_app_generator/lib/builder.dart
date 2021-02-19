import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'stacked_app_generator.dart';

Builder stackedRouterGenerator(BuilderOptions options) {
  // gr stands for generated router.
  return LibraryBuilder(
    StackedRouterGenerator(),
    generatedExtension: '.gr.dart',
  );
}
