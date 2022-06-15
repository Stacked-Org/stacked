import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/revert_template_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

RevertTemplateService _getService() => RevertTemplateService();

void main() {
  group('RevertTemplateServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('test Revert Template with no variables in the template -', () {
      group('Single line template tests', () {
        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          but the template has heading new lines and spaces/indentations which should also be stripped''',
            () async {
          final content = '''
    Revert This part
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert This part',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          and the template does not have any heading new lines and spaces/indentations''',
            () async {
          final content = '''Revert This part
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert This part',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          and the template does not have any heading new lines but does have heading spaces/indentations''',
            () async {
          final content = '''         Revert This part
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert This part',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          and the template does have heading new lines but does not have any heading spaces/indentations''',
            () async {
          final content = '''
Revert This part
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert This part',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });
      });

      group('Multi-line template tests With indentations', () {
        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines  but no heading empty lines or spaces (the new lines before the template)''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''int getSomeInt() {
  return 1;
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
return 1;
}''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, indentations and heading new lines (the new lines before the template) but no spaces/indentations''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''
int getSomeInt() {
  return 1;
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
return 1;
}''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, indentations, heading new lines (the new lines before the template) and spaces/indentations''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''
   int getSomeInt() {
  return 1;
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
return 1;
}''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, indentations and spaces/indentations but no heading new lines (the new lines before the template) ''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''     int getSomeInt() {
  return 1;
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
return 1;
}''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });
      });

      group('Multi-line template tests without indentations', () {
        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines but no heading empty lines (the new lines before the template) or spaces''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''import '../services/service_1.dart';
import '../serviced/service_2.dart';
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, heading empty lines (the new lines before the template) but no spaces''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''
import '../services/service_1.dart';
import '../serviced/service_2.dart';
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, heading empty lines (the new lines before the template) and spaces''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''
    import '../services/service_1.dart';
import '../serviced/service_2.dart';
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines and spaces but no heading empty lines (the new lines before the template)''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''    import '../services/service_1.dart';
import '../serviced/service_2.dart';
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';''',
            name: '',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });
      });
    });

    group('test Revert Template with variables in the template -', () {
      group('Single line template tests', () {
        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          but the template has heading new lines and spaces/indentations which should also be stripped''',
            () async {
          final content = '''
    Revert the service: Service1
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert the service: {{serviceName}}',
            name: 'service_1',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          and the template does not have any heading new lines and spaces/indentations''',
            () async {
          final content = '''Revert the service: Service1
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert the service: {{serviceName}}',
            name: 'service_1',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          and the template does not have any heading new lines but does have heading spaces/indentations''',
            () async {
          final content = '''         Revert the service: Service1
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert the service: {{serviceName}}',
            name: 'service_1',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Tests if the revertTemplateService works as expected when reverting a template with no new-lines
          and the template does have heading new lines but does not have any heading spaces/indentations''',
            () async {
          final content = '''
Revert the service: Service1
// @revertIdentifier''';
          final expected = '\n// @revertIdentifier';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: 'Revert the service: {{serviceName}}',
            name: 'service_1',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });
      });

      group('Multi-line template tests With indentations', () {
        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines  but no heading empty lines or spaces (the new lines before the template)''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''int getSomeInt() {
  final service = locator<IntService>;
  return service.getInt();
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
final service = locator<{{serviceName}}>;
return service.getInt();
}''',
            name: 'int_service',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, indentations and heading new lines (the new lines before the template) but no spaces/indentations''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''
int getSomeInt() {
  final service = locator<IntService>;
  return service.getInt();
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
final service = locator<{{serviceName}}>;
return service.getInt();
}''',
            name: 'int_service',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, indentations, heading new lines (the new lines before the template) and spaces/indentations''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''
   int getSomeInt() {
  final service = locator<IntService>;
  return service.getInt();
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
final service = locator<{{serviceName}}>;
return service.getInt();
}''',
            name: 'int_service',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, indentations and spaces/indentations but no heading new lines (the new lines before the template) ''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there are indents, that means the file has changed due to formatting the content.
          final content = '''     int getSomeInt() {
  final service = locator<IntService>;
  return service.getInt();
}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''int getSomeInt() {
final service = locator<{{serviceName}}>;
return service.getInt();
}''',
            name: 'int_service',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });
      });

      group('Multi-line template tests without indentations', () {
        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines but no heading empty lines (the new lines before the template) or spaces''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''import '../services/service_1.dart';
import '../serviced/service_2.dart';

class ImportantService {}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';

class {{serviceName}}Service{}''',
            name: 'important',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, heading empty lines (the new lines before the template) but no spaces''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''
import '../services/service_1.dart';
import '../serviced/service_2.dart';

class ImportantService {}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';

class {{serviceName}}Service{}''',
            name: 'important',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines, heading empty lines (the new lines before the template) and spaces''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''
    import '../services/service_1.dart';
import '../serviced/service_2.dart';

class ImportantService {}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';

class {{serviceName}}Service{}''',
            name: 'important',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });

        test(
            '''Test if the revertTemplateService works as expected when reverting a template 
            with new-lines and spaces but no heading empty lines (the new lines before the template)''',
            () async {
          getAndRegisterFileService();
          getAndRegisterProcessService();

          // as you can see there is no indents, that means nothing has changed due to formatting the content.
          final content = '''    import '../services/service_1.dart';
import '../serviced/service_2.dart';

class ImportantService {}
// @revertIdentifier''';
          final expected = '''// @revertIdentifier''';

          final templateService = _getService();
          final result =
              await templateService.templateWithoutModifiedFileContent(
            fileContent: content,
            modificationIdentifier: '// @revertIdentifier',
            modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';

class {{serviceName}}Service{}''',
            name: 'important',
            templateName: kTemplateNameService,
          );

          expect(result, expected);
        });
      });
    });
    group('tests to ensure the Service should only strip a max of 1 line', () {
      test(
          '''Test if the revertTemplateService strips only 1 line from the content, 
            with new-lines and spaces but no heading empty lines (the new lines before the template)''',
          () async {
        getAndRegisterFileService();
        getAndRegisterProcessService();

        // as you can see there is no indents, that means nothing has changed due to formatting the content.
        final content = '''

import '../services/service_1.dart';
import '../serviced/service_2.dart';

class ImportantService {}
// @revertIdentifier''';
        final expected = '''
// @revertIdentifier''';

        final templateService = _getService();
        final result = await templateService.templateWithoutModifiedFileContent(
          fileContent: content,
          modificationIdentifier: '// @revertIdentifier',
          modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';

class {{serviceName}}Service{}''',
          name: 'important',
          templateName: kTemplateNameService,
        );

        expect(result, expected);
      });

      test(
          '''Tests if the revertTemplateService strips only 1 line from the content with new-lines''',
          () async {
        final content = '''

Revert the service: Service1
// @revertIdentifier''';
        final expected = '\n// @revertIdentifier';

        final templateService = _getService();
        final result = await templateService.templateWithoutModifiedFileContent(
          fileContent: content,
          modificationIdentifier: '// @revertIdentifier',
          modificationTemplate: 'Revert the service: {{serviceName}}',
          name: 'service_1',
          templateName: kTemplateNameService,
        );

        expect(result, expected);
      });

      test(
          '''Test if the revertTemplateService strips a max of 1 line for a content with new-lines''',
          () async {
        getAndRegisterFileService();
        getAndRegisterProcessService();

        // as you can see there are indents, that means the file has changed due to formatting the content.
        final content = '''

int getSomeInt() {
  final service = locator<IntService>;
  return service.getInt();
}
// @revertIdentifier''';
        final expected = '''
// @revertIdentifier''';

        final templateService = _getService();
        final result = await templateService.templateWithoutModifiedFileContent(
          fileContent: content,
          modificationIdentifier: '// @revertIdentifier',
          modificationTemplate: '''int getSomeInt() {
final service = locator<{{serviceName}}>;
return service.getInt();
}''',
          name: 'int_service',
          templateName: kTemplateNameService,
        );

        expect(result, expected);
      });

      test(
          '''Test if the revertTemplateService strips only 1 line from the content, 
            with new-lines (without variable)''', () async {
        getAndRegisterFileService();
        getAndRegisterProcessService();

        // as you can see there is no indents, that means nothing has changed due to formatting the content.
        final content = '''

import '../services/service_1.dart';
import '../serviced/service_2.dart';

class Service {}
// @revertIdentifier''';
        final expected = '''
// @revertIdentifier''';

        final templateService = _getService();
        final result = await templateService.templateWithoutModifiedFileContent(
          fileContent: content,
          modificationIdentifier: '// @revertIdentifier',
          modificationTemplate: '''import '../services/service_1.dart';
import '../serviced/service_2.dart';

class Service{}''',
          name: '',
          templateName: kTemplateNameService,
        );

        expect(result, expected);
      });

      test(
          '''Tests if the revertTemplateService strips only 1 line from the content with new-lines (without variable)''',
          () async {
        final content = '''

Revert the service: Service1
// @revertIdentifier''';
        final expected = '\n// @revertIdentifier';

        final templateService = _getService();
        final result = await templateService.templateWithoutModifiedFileContent(
          fileContent: content,
          modificationIdentifier: '// @revertIdentifier',
          modificationTemplate: 'Revert the service: Service1',
          name: '',
          templateName: kTemplateNameService,
        );

        expect(result, expected);
      });

      test(
          '''Test if the revertTemplateService strips a max of 1 line for a content with new-lines (without variable)''',
          () async {
        getAndRegisterFileService();
        getAndRegisterProcessService();

        // as you can see there are indents, that means the file has changed due to formatting the content.
        final content = '''

int getSomeInt() {
  final service = locator<IntService>;
  return service.getInt();
}
// @revertIdentifier''';
        final expected = '''
// @revertIdentifier''';

        final templateService = _getService();
        final result = await templateService.templateWithoutModifiedFileContent(
          fileContent: content,
          modificationIdentifier: '// @revertIdentifier',
          modificationTemplate: '''int getSomeInt() {
final service = locator<IntService>;
return service.getInt();
}''',
          name: '',
          templateName: kTemplateNameService,
        );

        expect(result, expected);
      });
    });
  });
}
