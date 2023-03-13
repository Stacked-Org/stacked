import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class TestFormViewModel extends BaseViewModel with FormStateHelper {
  bool setFormStatusCalled = false;
  @override
  void setFormStatus() {
    setFormStatusCalled = true;
  }
}

void main() {
  group('FormStateHelperTest -', () {
    test('When initialised showValidationMessage Should be false', () {
      final viewmodel = TestFormViewModel();

      expect(viewmodel.showValidationMessage, isFalse);
    });
    test('When initialised validationMessage Should be null', () {
      final viewmodel = TestFormViewModel();

      expect(viewmodel.validationMessage, isNull);
    });
    test('When initialised formValueMap Should be empty', () {
      final viewmodel = TestFormViewModel();

      expect(viewmodel.formValueMap, isEmpty);
    });
    test('When initialised fieldsValidationMessages Should be empty', () {
      final viewmodel = TestFormViewModel();

      expect(viewmodel.fieldsValidationMessages, isEmpty);
    });

    group('setValidationMessage -', () {
      test('When set validation message, validationMessage Should not be null',
          () {
        final viewmodel = TestFormViewModel();
        viewmodel.setValidationMessage('value');
        expect(viewmodel.validationMessage, isNotNull);
      });
      test('When set validation message, validationMessage Should not be null',
          () {
        final viewmodel = TestFormViewModel();
        viewmodel.setValidationMessage('value');
        expect(viewmodel.validationMessage, isNotNull);
      });
    });
    group('setData -', () {
      test(
          'When set new data for a field, Should reset the validation message of that field if exist',
          () {
        final viewmodel = TestFormViewModel();
        viewmodel.setValidationMessages({'name': 'Name is not valid!'});
        viewmodel.setData({'name': 'newName'});

        expect(viewmodel.fieldsValidationMessages['name'], isNull);
      });
      test('When set data, Should call the setFormStatus method', () {
        final viewmodel = TestFormViewModel();
        viewmodel.setData({'name': 'newName'});

        expect(viewmodel.setFormStatusCalled, isTrue);
      });
    });
    group('setValidationMessages -', () {
      test(
          'When called with empty map, Should remove all old validation messages',
          () {
        final viewmodel = TestFormViewModel();
        viewmodel.setValidationMessages({});

        expect(viewmodel.fieldsValidationMessages, isEmpty);
      });
      test('When called with a value with null, Should filter it out', () {
        final viewmodel = TestFormViewModel();
        viewmodel.setValidationMessages({'name': null});

        expect(viewmodel.fieldsValidationMessages, isEmpty);
      });
      test('When called with a non-nullable value, Should add it', () {
        final viewmodel = TestFormViewModel();
        viewmodel.setValidationMessages({'name': 'tName'});

        expect(viewmodel.fieldsValidationMessages['name'], 'tName');
      });
    });
  });
}
