import 'package:mockito/mockito.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:test/test.dart';
import '../helpers/test_helpers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class TestProjectStructureValidator with ProjectStructureValidator {}

Matcher throwsInvalidStackedStructureExceptionWithMessage(
    String expectedMessage) {
  return throwsA(
    predicate((e) =>
        e is InvalidStackedStructureException && e.message == expectedMessage),
  );
}

void main() {
  late TestProjectStructureValidator validator;
  late ColorizedLogService cLogService;
  late Directory tempDir;
  late File pubspecFile;
  late File stackedFile;

  setUp(() {
    registerServices();
    validator = TestProjectStructureValidator();
    cLogService = locator<ColorizedLogService>();
  });
  tearDown(() => locator.reset());

  setUp(() async {
    return Future(() async {
      tempDir =
          await Directory.systemTemp.createTemp('test_project_structure_');
      pubspecFile = File(p.join(tempDir.path, 'pubspec.yaml'));
      final libDir = Directory(p.join(tempDir.path, 'lib'));
      await libDir.create();
      final appDir = Directory(p.join(libDir.path, 'app'));
      await appDir.create();

      stackedFile = File(p.join(appDir.path, 'app.dart'));
    });
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('ProjectStructureValidator', () {
    test('validateStructure: should throw an error if not at project root',
        () async {
      // Arrange
      // Do not create pubspec.yaml file

      // Act
      Future<void> action() async {
        await validator.validateStructure(outputPath: tempDir.path);
      }

      // Assert
      expect(
        action,
        throwsInvalidStackedStructureExceptionWithMessage(
          kInvalidRootDirectory,
        ),
      );
    });

    test(
        'validateStructure: should throw an error if not a stacked application',
        () async {
      // Arrange
      await pubspecFile.create();

      // Act
      Future<void> action() async {
        await validator.validateStructure(outputPath: tempDir.path);
      }

      // Assert
      expect(
        action,
        throwsInvalidStackedStructureExceptionWithMessage(
          kInvalidStackedStructure,
        ),
      );
    });
    test(
        'validateStructure: should not trhow an error if a stacked application and at root',
        () async {
      // Arrange
      await pubspecFile.create();
      await stackedFile.create();

      // Act
      Future<void> action() async {
        await validator.validateStructure(outputPath: tempDir.path);
      }

      // Assert
      await expectLater(action(), completes);
    });
  });

  group('validateOrganization', () {
    test('does not log an error for a valid organization name', () {
      validator.validateOrganization(organization: 'com.example');

      // Verify that the error method is not called on the cLogService
      verifyNever(cLogService.error(
          message: "Organization must be a valid bundle name. (com.example)"));
    });

    test('logs an error for an invalid organization name', () {
      validator.validateOrganization(organization: 'invalid_organization');

      // Verify that the error method is called on the cLogService with the expected message
      verify(cLogService.error(
        message: "Organization must be a valid bundle name. (com.example)",
      )).called(1);
    });

    test('does not log an error when organization is null', () {
      validator.validateOrganization(organization: null);

      // Verify that the error method is not called on the cLogService
      verifyNever(cLogService.error(
          message: "Organization must be a valid bundle name. (com.example)"));
    });
  });
  group('validateAppName', () {
    test('does not log an error for a valid app name', () {
      validator.validateAppName(appName: 'example_app');

      // Verify that the error method is not called on the cLogService
      verifyNever(cLogService.error(
          message:
              '''App name must contain lower letters and is not allowed to start 
          with numbers. Also it can't contain special characters, spaces and 
          should be different from dart reserved words.'''));
    });

    test('logs an error for an invalid app name: containing spaces', () {
      validator.validateAppName(appName: 'example app');

      // Verify that the error method is called on the cLogService with the expected message
      verify(cLogService.error(
        message:
            '''App name must contain lower letters and is not allowed to start 
          with numbers. Also it can't contain special characters, spaces and 
          should be different from dart reserved words.''',
      )).called(1);
    });

    test('logs an error for an invalid app name: containing upper case letter',
        () {
      validator.validateAppName(appName: 'eXample_app');

      // Verify that the error method is called on the cLogService with the expected message
      verify(cLogService.error(
        message:
            '''App name must contain lower letters and is not allowed to start 
          with numbers. Also it can't contain special characters, spaces and 
          should be different from dart reserved words.''',
      )).called(1);
    });
    test('logs an error for an invalid app name: starting with digit', () {
      validator.validateAppName(appName: '1_example_app');

      // Verify that the error method is called on the cLogService with the expected message
      verify(cLogService.error(
        message:
            '''App name must contain lower letters and is not allowed to start 
          with numbers. Also it can't contain special characters, spaces and 
          should be different from dart reserved words.''',
      )).called(1);
    });

    test('logs an error for an invalid app name: is reserved word', () {
      validator.validateAppName(appName: 'assert');

      // Verify that the error method is called on the cLogService with the expected message
      verify(cLogService.error(
        message:
            '''App name must contain lower letters and is not allowed to start 
          with numbers. Also it can't contain special characters, spaces and 
          should be different from dart reserved words.''',
      )).called(1);
    });

    test('does not log an error when organization is null', () {
      validator.validateAppName(appName: null);

      // Verify that the error method is not called on the cLogService
      verifyNever(cLogService.error(
          message:
              '''App name must contain lower letters and is not allowed to start 
          with numbers. Also it can't contain special characters, spaces and 
          should be different from dart reserved words.'''));
    });
  });
  // test('_isProjectRoot returns true if the outputPath contains pubspec.yaml',
  //     () async {
  //   // Create a temporary directory
  //   Directory tempDir = await Directory.systemTemp.createTemp();
  //   // Create a pubspec.yaml file inside the temporary directory
  //   File pubspecFile = File(path.join(tempDir.path, 'pubspec.yaml'));
  //   await pubspecFile.create();

  //   // Call the _isProjectRoot method with the outputPath set to the temporary directory path
  //   bool result = await validator._isProjectRoot(outputPath: tempDir.path);

  //   // Clean up the temporary directory
  //   await tempDir.delete(recursive: true);

  //   // Check if the result is true
  //   expect(result, true);
  // });
}
