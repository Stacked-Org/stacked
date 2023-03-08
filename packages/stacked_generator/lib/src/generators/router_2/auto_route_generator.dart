import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
// ignore: implementation_imports
import 'package:source_gen/src/output_helpers.dart';
import 'package:stacked_generator/src/generators/router_2/code_builder/library_builder.dart';
import 'package:stacked_generator/src/generators/router_2/resolvers/router_config_resolver.dart';
import 'package:stacked_generator/src/generators/router_common/resolvers/type_resolver.dart';

import '../../../utils.dart';
import 'resolvers/route_config_resolver.dart';

class AutoRouteGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final values = <String>{};
    for (var annotatedElement in library.annotatedWith(autoRouteChecker)) {
      final generatedValue = generateForAnnotatedElement(
          annotatedElement.element, annotatedElement.annotation, buildStep);
      await for (var value in normalizeGeneratorOutput(generatedValue)) {
        assert(value.length == value.trim().length);
        values.add(value);
      }
    }

    return values.join('\n\n');
  }

  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    // throw if annotation is used for a none class element
    throwIf(
      element is! ClassElement,
      '${element.name} is not a class element',
      element: element,
    );

    final clazz = element as ClassElement;
    final usesPartBuilder = _hasPartDirective(clazz);

    final TypeResolver typeResolver;

    if (usesPartBuilder) {
      typeResolver = TypeResolver(const []);
    } else {
      var libs = await buildStep.resolver.libraries.toList();
      Uri? targetFileUri;
      if (annotation.peek('preferRelativeImports')?.boolValue != false) {
        targetFileUri = element.source.uri;
      }
      typeResolver = TypeResolver(libs, targetFileUri);
    }

    final routerResolver = RouterConfigResolver(typeResolver);
    final routerConfig = routerResolver.resolve(
      annotation,
      clazz,
      usesPartBuilder: usesPartBuilder,
    );
    final deferredLoading =
        annotation.peek('deferredLoading')?.boolValue ?? false;
    return generateLibrary(
      routerConfig,
      usesPartBuilder: usesPartBuilder,
      deferredLoading: deferredLoading,
    );
  }

  bool _hasPartDirective(ClassElement clazz) {
    final fileName = clazz.source.uri.pathSegments.last;
    final part = fileName.replaceAll(
      '.dart',
      '.gr.dart',
    );
    return clazz.library.parts.any(
      (e) => e.toString().endsWith(part),
    );
  }
}
