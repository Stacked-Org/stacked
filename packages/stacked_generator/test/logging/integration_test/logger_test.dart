import 'package:test/test.dart';

import '../../helpers/common.dart';

void main() {
  group('Logger -', () {
    group('disablereleasemode -', () {
      test('has no compile issue', () async {
        await checkCodeForCompilationError(
          generatorName: 'stacked_generator',
          relativePath: 'test/logging/integration_test/samples/',
          fileName: 'logger_disablereleasemode.logger',
        );
      });
    });
  });
}
