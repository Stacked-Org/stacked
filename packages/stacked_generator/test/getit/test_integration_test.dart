import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  test('has no issue', () async {
    var getitexamplelocator = 'getit_example.locator';
    final main = await resolveSources(
      {
        'stacked_generator|test/integration/$getitexamplelocator.dart':
            useAssetReader,
      },
      (r) => r.libraries.firstWhere((element) {
        /// [element.source.toString()] will print "getit_example.locator.dart"
        return element.source.toString().contains(getitexamplelocator);
      }),
    );

    final errorResult = await main.session.getErrors(
            '/stacked_generator/test/integration/$getitexamplelocator.dart')
        as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });
}
