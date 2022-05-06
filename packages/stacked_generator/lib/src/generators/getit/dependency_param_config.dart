class DependencyParamConfig {
  final String? name;
  final bool isPositional;
  final bool isRequired;

  /// Can't figure out the perpose of this field
  final String? defaultValueCode;

  /// The required imports of the generated service
  final Set<String>? imports;

  /// Must contains a '?' mark(nullable type)
  final String? type;

  /// When set this to [true] make sure that [type] is not null
  final bool isFactoryParam;

  DependencyParamConfig({
    this.type,
    this.name,
    this.isFactoryParam = false,
    this.isPositional = false,
    this.isRequired = false,
    this.defaultValueCode,
    this.imports,
  }) : assert(isFactoryParam == false || type != null);
}
