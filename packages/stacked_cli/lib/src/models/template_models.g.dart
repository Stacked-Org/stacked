// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CompliledTemplateFile _$$_CompliledTemplateFileFromJson(
        Map<String, dynamic> json) =>
    _$_CompliledTemplateFile(
      templateName: json['templateName'] as String,
      templateFileName: json['templateFileName'] as String,
      templateFilePath: json['templateFilePath'] as String,
      templateFileContent: json['templateFileContent'] as String,
    );

Map<String, dynamic> _$$_CompliledTemplateFileToJson(
        _$_CompliledTemplateFile instance) =>
    <String, dynamic>{
      'templateName': instance.templateName,
      'templateFileName': instance.templateFileName,
      'templateFilePath': instance.templateFilePath,
      'templateFileContent': instance.templateFileContent,
    };

_$_CompiledStackedTemplate _$$_CompiledStackedTemplateFromJson(
        Map<String, dynamic> json) =>
    _$_CompiledStackedTemplate(
      templateName: json['templateName'] as String,
      templateFiles: (json['templateFiles'] as List<dynamic>)
          .map((e) => CompliledTemplateFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      fileModifications: (json['fileModifications'] as List<dynamic>?)
              ?.map((e) =>
                  CompiledFileModification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CompiledStackedTemplateToJson(
        _$_CompiledStackedTemplate instance) =>
    <String, dynamic>{
      'templateName': instance.templateName,
      'templateFiles': instance.templateFiles,
      'fileModifications': instance.fileModifications,
    };

_$_CompiledFileModification _$$_CompiledFileModificationFromJson(
        Map<String, dynamic> json) =>
    _$_CompiledFileModification(
      modificationPath: json['modificationPath'] as String,
      modificationIndentifier: json['modificationIndentifier'] as String,
      modificationTemplate: json['modificationTemplate'] as String,
      modificationErrorMessage: json['modificationErrorMessage'] as String,
    );

Map<String, dynamic> _$$_CompiledFileModificationToJson(
        _$_CompiledFileModification instance) =>
    <String, dynamic>{
      'modificationPath': instance.modificationPath,
      'modificationIndentifier': instance.modificationIndentifier,
      'modificationTemplate': instance.modificationTemplate,
      'modificationErrorMessage': instance.modificationErrorMessage,
    };
