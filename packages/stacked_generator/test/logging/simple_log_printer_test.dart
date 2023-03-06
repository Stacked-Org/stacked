import 'dart:isolate';

import 'package:stacked_generator/src/generators/logging/logger_builder.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';
import 'package:test/test.dart';

void main() {
  group('SimpleLogPrinterTest -', () {
    test('returns a correct log message.', () async {
      final loggerBuilder = LoggerBuilder(loggerConfig: LoggerConfig()).addLoggerClassConstantBody();

      final code = loggerBuilder.serializeStringBuffer;

      final uri = Uri.dataFromString(
        '''
        import "dart:isolate";
        import 'package:logger/logger.dart';

        const kReleaseMode = false;
        const kIsWeb = false;

        $code

        void main(_, SendPort port) {
          final logger = SimpleLogPrinter('classname');
          final result = logger.log(LogEvent(Level.verbose, 'verbose'));

          port.send(result.join('\\n'));
        }
        ''',
        mimeType: 'application/dart',
      );

      final port = ReceivePort();
      await Isolate.spawnUri(uri, [], port.sendPort);

      final String response = await port.first;

      expect(response, contains('classname |  - verbose'));
    });

    test('attaches the stacktrace if requested.', () async {
      final loggerBuilder = LoggerBuilder(loggerConfig: LoggerConfig()).addLoggerClassConstantBody();

      final code = loggerBuilder.serializeStringBuffer;

      final uri = Uri.dataFromString(
        '''
        import "dart:isolate";
        import 'package:logger/logger.dart';

        const kReleaseMode = false;
        const kIsWeb = false;

        $code

        void main(_, SendPort port) {
          final logger = SimpleLogPrinter('classname', printCallStack: true);
          final result = logger.log(LogEvent(Level.info, 'info'));

          port.send(result.join('\\n'));
        }
        ''',
        mimeType: 'application/dart',
      );

      final port = ReceivePort();
      await Isolate.spawnUri(uri, [], port.sendPort);

      final String response = await port.first;

      expect(response, contains('classname |  - info'));
      expect(response, contains('STACKTRACE:'));
    });

    test('prints error object if provided.', () async {
      final loggerBuilder = LoggerBuilder(loggerConfig: LoggerConfig()).addLoggerClassConstantBody();

      final code = loggerBuilder.serializeStringBuffer;

      final uri = Uri.dataFromString(
        '''
        import "dart:isolate";
        import 'package:logger/logger.dart';

        const kReleaseMode = false;
        const kIsWeb = false;

        $code

        void main(_, SendPort port) {
          final logger = SimpleLogPrinter('classname');
          final result = logger.log(LogEvent(Level.error, 'error', Exception('error')));

          port.send(result.join('\\n'));
        }
        ''',
        mimeType: 'application/dart',
      );

      final port = ReceivePort();
      await Isolate.spawnUri(uri, [], port.sendPort);

      final String response = await port.first;

      expect(response, contains('classname |  - error'));
      expect(response, contains('ERROR: Exception: error'));
    });
  });
}
