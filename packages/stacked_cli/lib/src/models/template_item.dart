import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_item.freezed.dart';
part 'template_item.g.dart';

@freezed
class TemplateItem with _$TemplateItem {
  factory TemplateItem({
    /// Pascal case name of the template this file belongs too
    required String templateName,

    /// Pascal case name of the file without the extension
    required String templateFileName,

    /// Relative file path from the template in the templates folder
    /// .i.e. from we don't include template/view/
    required String templateFilePath,

    /// The content as is from the file that was read
    required String templateFileContent,
  }) = _TemplateItem;

  factory TemplateItem.fromJson(Map<String, dynamic> json) =>
      _$TemplateItemFromJson(json);
}
