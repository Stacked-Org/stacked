// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Config _$$_ConfigFromJson(Map<String, dynamic> json) => _$_Config(
      viewsPath: json['views_path'] as String? ?? 'lib/ui/views',
      servicesPath: json['services_path'] as String? ?? 'lib/services',
      stackedAppPath: json['stacked_app_path'] as String? ?? 'lib/app/app.dart',
      testHelpersPath: json['test_helpers_path'] as String? ?? 'test/helpers',
      testServicesPath:
          json['test_services_path'] as String? ?? 'test/services',
      testViewsPath: json['test_views_path'] as String? ?? 'test/viewmodels',
      locatorName: json['locator_name'] as String? ?? 'locator',
      registerMocksFunction:
          json['register_mocks_function'] as String? ?? 'registerServices',
      useViewModelBuilderStyle:
          json['use_view_model_builder_style'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ConfigToJson(_$_Config instance) => <String, dynamic>{
      'views_path': instance.viewsPath,
      'services_path': instance.servicesPath,
      'stacked_app_path': instance.stackedAppPath,
      'test_helpers_path': instance.testHelpersPath,
      'test_services_path': instance.testServicesPath,
      'test_views_path': instance.testViewsPath,
      'locator_name': instance.locatorName,
      'register_mocks_function': instance.registerMocksFunction,
      'use_view_model_builder_style': instance.useViewModelBuilderStyle,
    };
