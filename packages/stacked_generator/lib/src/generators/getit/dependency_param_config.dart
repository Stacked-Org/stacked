class DependencyParamConfig {
  final String? type;
  final String? name;
  final String? alias;
  final bool isPositional;
  final bool isRequired;
  final String? defaultValueCode;
  final Set<String>? imports;
  final bool isFactoryParam;

  DependencyParamConfig({
    this.type,
    this.name,
    this.alias,
    this.isFactoryParam = false,
    this.isPositional = false,
    this.isRequired = false,
    this.defaultValueCode,
    this.imports,
  });
}
