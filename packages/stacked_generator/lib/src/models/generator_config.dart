// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'generator_config.freezed.dart';
part 'generator_config.g.dart';

@freezed
class GeneratorConfig with _$GeneratorConfig {
  factory GeneratorConfig({
    @Default(false) bool navigator2,
  }) = _GeneratorConfig;

  factory GeneratorConfig.fromJson(Map<String, dynamic> json) =>
      _$GeneratorConfigFromJson(json);
}
