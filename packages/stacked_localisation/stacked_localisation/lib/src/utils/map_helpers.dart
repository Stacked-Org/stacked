/// Takes in a Map that has 1 level deep nesting and combines the keys of the parent
/// object with the children object.
///
/// A map as follows:
/// {
///   'parent' : {
///     'child': 'value
///   }
/// }
///
/// will become
///
/// {
///   'parent.child': 'value',
/// }
Map<String, String> flattenMap(Map<String, dynamic> map) {
  Map<String, String> flatMap = Map<String, String>();
  var parentKeys = map.keys;
  for (var parentKey in parentKeys) {
    var childMap = map[parentKey] as Map<String, dynamic>;
    var childKeys = childMap.keys;
    for (var childKey in childKeys) {
      var flatKey = '$parentKey.$childKey';
      flatMap[flatKey] = map[parentKey][childKey].toString();
    }
  }

  return flatMap;
}
