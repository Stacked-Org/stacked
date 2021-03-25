import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/stacked_form_content_generator.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

class StackedFormGenerator extends GeneratorForAnnotation<FormView> {
  @override
  dynamic generateForAnnotatedElement(
    Element classForAnnotation,
    ConstantReader formView,
    BuildStep buildStep,
  ) async {
    var libs = await buildStep.resolver.libraries.toList();
    var importResolver =
        ImportResolver(libs, classForAnnotation.source?.uri.path ?? '');

    final viewName = classForAnnotation.displayName;

    final fieldsConfig = formView.peek('fields')?.listValue;
    List<FieldConfig> fields = <FieldConfig>[];

    if (fieldsConfig != null) {
      for (final fieldConfig in fieldsConfig) {
        final serialisedField = _readFieldConfig(
            fieldConfig: fieldConfig, importResolver: importResolver);

        fields.add(serialisedField);
      }
    }

    final formViewConfig = FormViewConfig(
      fields: fields,
      viewName: viewName,
    );

    return StackedFormContentGenerator(formViewConfig).generate();
  }
}

FieldConfig _readFieldConfig({
  required DartObject fieldConfig,
  required ImportResolver importResolver,
}) {
  var fieldReader = ConstantReader(fieldConfig);

  bool isTextField =
      fieldReader.instanceOf(TypeChecker.fromRuntime(FormTextField));
  bool isDateField =
      fieldReader.instanceOf(TypeChecker.fromRuntime(FormDateField));

  if (isTextField) {
    return _readTextFieldConfig(
        fieldReader: fieldReader, importResolver: importResolver);
  } else if (isDateField) {
    return _readDateFieldConfig(
        fieldReader: fieldReader, importResolver: importResolver);
  } else {
    throw ArgumentError('Unknown form field $fieldConfig');
  }
}

FieldConfig _readTextFieldConfig({
  ConstantReader fieldReader,
  ImportResolver importResolver,
}) {
  final String name = (fieldReader.peek('name')?.stringValue) ?? '';
  return TextFieldConfig(
    name: name,
  );
}

FieldConfig _readDateFieldConfig({
  ConstantReader fieldReader,
  ImportResolver importResolver,
}) {
  final String name = (fieldReader.peek('name')?.stringValue) ?? '';
  return DateFieldConfig(
    name: name,
  );
}
