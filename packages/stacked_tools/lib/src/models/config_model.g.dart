// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Config _$$_ConfigFromJson(Map<String, dynamic> json) => _$_Config(
      stackedAppPath: json['stackedAppPath'] as String? ?? 'lib/app/app.dart',
      viewPath: json['viewPath'] as String? ?? 'lib/ui/views',
      viewTestsPath: json['viewTestsPath'] as String? ?? 'test/viewmodel',
      servicePath: json['servicePath'] as String? ?? 'lib/services',
      serviceTestsPath: json['serviceTestsPath'] as String? ?? 'test/service',
      testHelpersPath: json['testHelpersPath'] as String? ?? 'test/helpers',
      testMocksPath: json['testMocksPath'] as String? ?? 'test/helpers',
    );

Map<String, dynamic> _$$_ConfigToJson(_$_Config instance) => <String, dynamic>{
      'stackedAppPath': instance.stackedAppPath,
      'viewPath': instance.viewPath,
      'viewTestsPath': instance.viewTestsPath,
      'servicePath': instance.servicePath,
      'serviceTestsPath': instance.serviceTestsPath,
      'testHelpersPath': instance.testHelpersPath,
      'testMocksPath': instance.testMocksPath,
    };
