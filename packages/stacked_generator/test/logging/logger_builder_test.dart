import 'package:stacked_generator/src/generators/logging/logger_builder.dart';
import 'package:stacked_generator/src/generators/logging/logger_class_content.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';
import 'package:test/test.dart';

import '../helpers/test_constants/logger_constants.dart';

void main() {
  group('LoggerBuilderTest -', () {
    group('addImports -', () {
      test('loggerConfig has two imports', () {
        final loggerBuilder = LoggerBuilder(
            loggerConfig: LoggerConfig(imports: {
          'packageX/importOne.dart',
          'packageY/importTwo.dart',
        })).addImports();

        expect(loggerBuilder.serializeStringBuffer, addLoggerClassImports);
      });
    });
    group('addLoggerClassConstantBody -', () {
      test('loggerConfig default', () {
        final loggerBuilder = LoggerBuilder(loggerConfig: LoggerConfig())
            .addLoggerClassConstantBody();

        expect(loggerBuilder.serializeStringBuffer, loggerClassConstantBody);
      });
    });
    group('addLoggerNameAndOutputs -', () {
      test('loggerConfig default', () {
        final loggerBuilder = LoggerBuilder(loggerConfig: LoggerConfig())
            .addLoggerNameAndOutputs();

        expect(
            loggerBuilder.serializeStringBuffer, addLoggerClassNameAndOutput);
      });
    });
  });
}
