// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CompliledTemplateFile _$$_CompliledTemplateFileFromJson(
        Map<String, dynamic> json) =>
    _$_CompliledTemplateFile(
      name: json['name'] as String,
      fileName: json['fileName'] as String,
      path: json['path'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_CompliledTemplateFileToJson(
        _$_CompliledTemplateFile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fileName': instance.fileName,
      'path': instance.path,
      'content': instance.content,
    };

_$_CompiledStackedTemplate _$$_CompiledStackedTemplateFromJson(
        Map<String, dynamic> json) =>
    _$_CompiledStackedTemplate(
      name: json['name'] as String,
      templateFiles: (json['templateFiles'] as List<dynamic>)
          .map((e) => CompliledTemplateFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      modificationFiles: (json['modificationFiles'] as List<dynamic>?)
              ?.map((e) =>
                  CompiledFileModification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CompiledStackedTemplateToJson(
        _$_CompiledStackedTemplate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'templateFiles': instance.templateFiles.map((e) => e.toJson()).toList(),
      'modificationFiles':
          instance.modificationFiles.map((e) => e.toJson()).toList(),
    };

_$_CompiledFileModification _$$_CompiledFileModificationFromJson(
        Map<String, dynamic> json) =>
    _$_CompiledFileModification(
      description: json['description'] as String,
      path: json['path'] as String,
      identifier: json['identifier'] as String,
      template: json['template'] as String,
      error: json['error'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_CompiledFileModificationToJson(
        _$_CompiledFileModification instance) =>
    <String, dynamic>{
      'description': instance.description,
      'path': instance.path,
      'identifier': instance.identifier,
      'template': instance.template,
      'error': instance.error,
      'name': instance.name,
    };
