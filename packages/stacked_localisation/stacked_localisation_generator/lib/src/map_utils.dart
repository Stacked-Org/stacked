import 'package:mustache/mustache.dart';

const String _LocalisationStringsClassDefinition = '''
    class LocalisationStrings { 

    }
    ''';

const String GeneratorComment = '''
/// This code is generated. DO NOT edit by hand
''';

const String _MustacheTemplate = '''
{{{generatorComment}}}

{{#stringClasses}}
class {{className}} {
  {{#keys}}
  static String {{propertyName}} = '{{propertyValue}}';
  {{/keys}}
}
{{/stringClasses}}
''';

String getStringKeysCodeFromMap(Map<dynamic, dynamic> languageMap) {
  var template = Template(_MustacheTemplate);
  var classInfos = List<StringsClassInfo>();
  for (var viewKey in languageMap.keys) {
    var classMap = languageMap[viewKey] as Map;
    var classProperties = classMap.keys
        .map((propertyKey) => PropertyInfo(
            propertyName: propertyKey, propertyValue: '$viewKey.$propertyKey'))
        .toList();
    var info =
        StringsClassInfo(className: viewKey + 'Strings', keys: classProperties);
    classInfos.add(info);
  }

  var output = template.renderString({
    'generatorComment': GeneratorComment,
    'stringClasses': classInfos,
  });
  return output;
}

class StringsClassInfo {
  final String className;
  final List<PropertyInfo> keys;

  StringsClassInfo({this.className, this.keys});
}

class PropertyInfo {
  final String propertyName;
  final String propertyValue;

  PropertyInfo({this.propertyName, this.propertyValue});
}
