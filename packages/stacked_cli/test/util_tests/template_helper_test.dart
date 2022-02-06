import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:stacked_cli/src/templates/template_helper.dart';
import 'package:test/test.dart';

void main() {
  group('TemplateHelperTest -', () {
    group('getTemplatesFilesOnly -', () {
      test(
          'When given list of files where 1 ends in .stk, should return that file only',
          () {
        final helper = TemplateHelper();
        final templateFiles = helper.getTemplatesFilesOnly(filePaths: [
          File('non-template.dart'),
          File('non-template.text'),
          File('non-template.string'),
          File('non-template.dart.stk'),
          File('non-template.dart.as'),
        ]);

        expect(templateFiles.first.path, 'non-template.dart.stk');
      });
    });

    group('getFilesForTemplate -', () {
      test(
          'When given list of files where 2 contains templates\\view , should return those 2 files only',
          () {
        final helper = TemplateHelper();
        final templateDirectory = p.join('templates', 'view');
        final templateFiles = helper.getFilesForTemplate(
          filePaths: [
            File('non-template.dart'),
            File('non-template.text'),
            File('${templateDirectory}non-template.string'),
            File('non-template.dart.stk'),
            File('${templateDirectory}non-template.dart.as'),
          ],
          templateName: 'view',
        );

        // NOTE: We cannot compare 2 dart:io:File objects with the same path, they are not
        // equal. Therefore this unit test maps the file path to a list before comparison
        expect(templateFiles.map((e) => e.path), [
          '${templateDirectory}non-template.string',
          '${templateDirectory}non-template.dart.as',
        ]);
      });
    });
  });
}
