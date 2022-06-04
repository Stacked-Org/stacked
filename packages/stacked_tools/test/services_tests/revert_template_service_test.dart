import 'package:mockito/mockito.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/models/template_models.dart';
import 'package:stacked_tools/src/services/render_template_service.dart';
import 'package:stacked_tools/src/services/revert_template_service.dart';
import 'package:stacked_tools/src/services/template_service_utils.dart';
import 'package:stacked_tools/src/templates/compiled_template_map.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

RevertTemplateService _getRevertService() => RevertTemplateService();

void main() {
  group('RevertTemplateServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('revertContentForTemplate -', () {
      test(
          'Tests if the revertTemplateService works as expected when reverting a template with no new-lines',
          () async {
        final content = '''
        Revert This part
        // @revertIdentifier
    ''';
        final expected = '''
        
        // @revertIdentifier
    ''';

        final templateService = _getRevertService();
        final result = await templateService.templateWithoutModifiedFileContent(
          fileContent: content,
          modificationIdentifier: '// @revertIdentifier',
          modificationTemplate: 'Revert This part',
          name: '',
          templateName: kTemplateNameService,
        );

        expect(result, expected);
      });

      test(
          'Test if the revertTemplateService works as expected when reverting a template with new-lines',
          () async {
        getAndRegisterFileService();
        getAndRegisterProcessService();

        final content = '''int getSomeInt() {
  return 1;
}
// @revertIdentifier''';
        final expected = '''// @revertIdentifier''';

        final templateService = _getRevertService();
        final result = await templateService.templateWithoutModifiedFileContent(
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
  });
}
