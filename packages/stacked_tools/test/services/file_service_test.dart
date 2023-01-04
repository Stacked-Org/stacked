import 'dart:io';

import 'package:recase/recase.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/templates/compiled_templates.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';
import '../test_constants.dart';

FileService _getService() => FileService();

void main() {
  group('FileServiceTest -', () {
    setUp(() {
      registerServices();
    });
    tearDown(() async {
      await deleteTestFile();
      locator.reset();
    });
    group('removeSpecificFileLines -', () {
      test(
          'when called with filepath & content lines holding content should be removed from the file',
          () async {
        createTestFile(kAppTemplateAppContent);
        String content = "home";
        var recasedContent = ReCase(content);
        final fileService = _getService();
        await fileService.removeSpecificFileLines(
            filePath: ksTestFileName, removedContent: content);
        List<String> file = await File(ksTestFileName).readAsLines();
        expect(
            file.contains(recasedContent.snakeCase) ||
                file.contains('${recasedContent.pascalCase}View'),
            false);
      });

      test(
          'when called with filepath & content with type service lines holding content should be removed from the file',
          () async {
        createTestFile(kAppTemplateTestHelpersContent);
        String content = "navigation";
        var recasedContent = ReCase(content);
        final fileService = _getService();
        await fileService.removeSpecificFileLines(
          filePath: ksTestFileName,
          removedContent: content,
          type: kTemplateNameService,
        );
        String file = await File(ksTestFileName).readAsString();
        expect(
            file.contains(recasedContent.snakeCase) ||
                file.contains('${recasedContent.pascalCase}Service'),
            false);
      });
    });
  });
}
