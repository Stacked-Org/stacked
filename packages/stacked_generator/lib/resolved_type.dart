import 'package:code_builder/code_builder.dart' show TypeReference;

class ResolvedType {
  String? import;
  String name;
  bool isNullable;
  List<ResolvedType> typeArguments;

  ResolvedType({
    required this.name,
    this.import,
    this.typeArguments = const [],
    this.isNullable = false,
  });

  String get identity => "$import#$name";

  TypeReference get refer {
    print('name: $name, typeArguments: ${typeArguments}');

    /// When this (bug)[https://github.com/dart-lang/code_builder/issues/315] is fixed
    /// use the isNullable flag instead of adding '?' expicitly
    return TypeReference((b) => b
      ..symbol = isNullable ? name + '?' : name
      ..url = import
      ..types.addAll(typeArguments.map((e) => e.refer)));
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResolvedType &&
          runtimeType == other.runtimeType &&
          identity == other.identity;

  @override
  int get hashCode => import.hashCode ^ name.hashCode;

  ResolvedType copyWith({
    String? import,
    String? name,
    List<ResolvedType>? typeArguments,
    bool? isNullable,
  }) {
    return new ResolvedType(
      import: import ?? this.import,
      name: name ?? this.name,
      isNullable: isNullable ?? this.isNullable,
      typeArguments: typeArguments ?? this.typeArguments,
    );
  }
}
