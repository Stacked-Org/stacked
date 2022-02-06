// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TemplateItem _$$_TemplateItemFromJson(Map<String, dynamic> json) =>
    _$_TemplateItem(
      templateName: json['templateName'] as String,
      templateFileName: json['templateFileName'] as String,
      templateFilePath: json['templateFilePath'] as String,
      templateFileContent: json['templateFileContent'] as String,
    );

Map<String, dynamic> _$$_TemplateItemToJson(_$_TemplateItem instance) =>
    <String, dynamic>{
      'templateName': instance.templateName,
      'templateFileName': instance.templateFileName,
      'templateFilePath': instance.templateFilePath,
      'templateFileContent': instance.templateFileContent,
    };
