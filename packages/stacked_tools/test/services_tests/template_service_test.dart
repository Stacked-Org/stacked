import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/template_service_utils.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

TemplateServiceUtils _getService() => TemplateServiceUtils();

void main() {
  group('TemplateServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('getTemplateOutputPath -', () {
      test(
          'When given a path generic/generic.dart with viewName orderDetails, should return order_details/order_details.dart',
          () {
        final service = _getService();
        final result = service.getTemplateOutputPath(
          inputTemplatePath: 'generic/generic.dart',
          name: 'orderDetails',
        );
        expect(result, 'order_details/order_details.dart');
      });

      test(
          'When given a path generic/generic.dart.stk with viewName orderDetails, should return order_details/order_details.dart',
          () {
        final service = _getService();
        final result = service.getTemplateOutputPath(
          inputTemplatePath: 'generic/generic.dart.stk',
          name: 'orderDetails',
        );
        expect(result, 'order_details/order_details.dart');
      });

      test(
          'When given a path generic/generic.dart.stk with viewName orderDetails and outputPath playg§round, should return playground/order_details/order_details.dart',
          () {
        final service = _getService();
        final result = service.getTemplateOutputPath(
            inputTemplatePath: 'generic/generic.dart.stk',
            name: 'orderDetails',
            outputFolder: 'playground');
        expect(result, 'playground/order_details/order_details.dart');
      });
    });

    group('getTemplateRenderData -', () {
      test(
          'When given renderTemplates with no values and templateName stacked, should throw exception',
          () {
        final service = _getService();
        expect(
          () => service.getTemplateRenderData(
              templateName: 'stacked', testRenderFunctions: {}, name: ''),
          throwsA(
            predicate((e) => e is Exception),
          ),
        );
      });
      test(
          'When given renderTemplate snakeCase and templateName snakeCase, should convert the property to snake_case',
          () {
        final service = _getService();
        final result = service.getTemplateRenderData(
            templateName: 'snakeCase',
            name: 'stackedCli',
            testRenderFunctions: {
              'snakeCase': (recaseValue) => {
                    'name': recaseValue.snakeCase,
                  }
            });

        expect(result['name'], 'stacked_cli');
      });
    });
  });
}
