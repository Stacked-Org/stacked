import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';
import 'package:stacked_cli/src/templates/template_helper.dart';
import 'package:stacked_cli/src/templates/template_render_functions.dart';
import 'package:test/test.dart';

import '../helpers/test_helpers.dart';

TemplateHelper _getHelper() => TemplateHelper();

void main() {
  group('getFilePath -', () {
    test('When given path lib/app/app.dart should return app/app.locator.dart',
        () {
      getAndRegisterConfigService(stackedAppFilePath: 'lib/app/app.dart');
      final path = getFilePath(builder: 'locator');
      expect(path, 'app/app.locator.dart');
    });

    test(
        'When given path lib/src/app/core_app.dart should return src/app/core_app.locator.dart',
        () {
      getAndRegisterConfigService(
        stackedAppFilePath: 'lib/src/app/core_app.dart',
      );
      final path = getFilePath(builder: 'locator');
      expect(path, 'src/app/core_app.locator.dart');
    });

    test(
        'When given path lib/app/app.dart and builder equals router should return app/app.router.dart',
        () {
      getAndRegisterConfigService(stackedAppFilePath: 'lib/app/app.dart');
      final path = getFilePath(builder: 'router');
      expect(path, 'app/app.router.dart');
    });

    test(
        'When given path lib/app/app.dart and builder equals bottomsheets should return app/app.bottomsheets.dart',
        () {
      getAndRegisterConfigService(stackedAppFilePath: 'lib/app/app.dart');
      final path = getFilePath(builder: 'bottomsheets');
      expect(path, 'app/app.bottomsheets.dart');
    });

    test(
        'When given path lib/app/app.dart and builder equals dialogs should return app/app.dialogs.dart',
        () {
      getAndRegisterConfigService(stackedAppFilePath: 'lib/app/app.dart');
      final path = getFilePath(builder: 'dialogs');
      expect(path, 'app/app.dialogs.dart');
    });
  });

  group('TemplateHelperTest -', () {
    setUp(registerServices);
    tearDown(locator.reset);

    group('getTemplatesFilesOnly -', () {
      test(
          'When given list of files where 1 ends in .stk, should return that file only',
          () {
        final helper = _getHelper();
        final templateFiles = helper.getFilesWithExtension(
          filePaths: [
            File('non-template.dart'),
            File('non-template.text'),
            File('non-template.string'),
            File('non-template.dart.stk'),
            File('non-template.dart.as'),
          ],
          extension: 'stk',
        );

        expect(templateFiles.first.path, 'non-template.dart.stk');
      });
    });

    group('getFilesThatContainSection -', () {
      test(
          'When called with files where 2 has templates\\section in it and secion "templates\\section", should return those two files',
          () {
        final helper = _getHelper();
        final result = helper.getFilesThatContainSection(
          files: [
            File('my\\file\\not\\in\\section'),
            File('my\\file\\not\\in2\\section'),
            File('my\\file\\templates\\section'),
            File('my\\file\\not\\in3\\section'),
            File('templates\\section\\'),
            File('my\\file\\not\\in\\section4'),
          ],
          section: 'templates\\section',
        );
        expect(result.map((e) => e.path), [
          'my\\file\\templates\\section',
          'templates\\section\\',
        ]);
      });
    });

    group('getFilesForTemplate -', () {
      test(
          'When called with any templateName, should get the templates path from the pathService',
          () async {
        final pathService = getAndRegisterPathService();
        final helper = _getHelper();
        await helper.getFilesForTemplate(templateName: kTemplateNameView);
        verify(pathService.templatesPath);
      });

      test(
          'When called with any templateName, should get the files in directory with path from pathService',
          () async {
        final fileService = getAndRegisterFileService();
        final helper = _getHelper();
        await helper.getFilesForTemplate(templateName: kTemplateNameView);
        verify(fileService.getFilesInDirectory(directoryPath: 'template_path'));
      });

      test('When called with view, should join templates and view', () async {
        final pathService = getAndRegisterPathService();
        final helper = _getHelper();
        await helper.getFilesForTemplate(templateName: kTemplateNameView);
        verify(pathService.join('templates', kTemplateNameView));
      });

      test(
          'When given list of files where 2 contains templates\\view , should return those 2 files only',
          () async {
        final templateDirectory = p.join('templates', kTemplateNameView);

        getAndRegisterPathService(joinResult: templateDirectory);

        getAndRegisterFileService(getFilesInDirectoryResult: [
          File('non-template.dart'),
          File('non-template.text'),
          File('$templateDirectory\\generic.string.stk'),
          File('non-template.dart.stk'),
          File('$templateDirectory\\open.dart.as.stk'),
        ]);

        final helper = _getHelper();
        final templateFiles = await helper.getFilesForTemplate(
          templateName: kTemplateNameView,
        );

        // NOTE: We cannot compare 2 dart:io:File objects with the same path, they are not
        // equal. Therefore this unit test maps the file path to a list before comparison
        expect(
          templateFiles.map((e) => e.path).toList(),
          [
            '$templateDirectory\\generic.string.stk',
            '$templateDirectory\\open.dart.as.stk',
          ],
        );
      });
    });
  });
}
