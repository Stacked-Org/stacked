import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';

const _constImports = [
  "package:stacked/stacked.dart",
  "package:stacked_services/stacked_services.dart"
];

class RouteGeneratorBuilder with StringBufferUtils {
  final List<RouteConfig> routes;

  RouteGeneratorBuilder(this.routes);

  RouteGeneratorBuilder addHeaderComment() {
    write(
        "// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names");
    return this;
  }

  RouteGeneratorBuilder sortAndaddImports() {
    final allImports = routes
        .map((route) => route.registerImports())
        .fold<Set<String>>(
            {}, (previousValue, element) => {...previousValue, ...element});

    final dartImports =
        allImports.where((element) => element.startsWith('dart'));
    generateAndAddNewLines(dartImports, preLines: 1, postlines: 1);

    final packageImports =
        allImports.where((element) => element.startsWith('package'));
    generateAndAddNewLines([...packageImports, ..._constImports], postlines: 1);

    final remainingImports =
        allImports.difference({...dartImports, ...packageImports});
    generateAndAddNewLines(remainingImports);

    return this;
  }
}
