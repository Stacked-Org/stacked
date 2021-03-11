/// The class to describe a service registration on the get_it locator
class DependencyRegistration {
  /// The type of the service to register
  final Type classType;

  /// An abstracted class type of service to register
  final Type asType;

  final Function resolveUsing;

  const DependencyRegistration(
      {this.classType, this.asType, this.resolveUsing});
}

/// Registers the type passed in as a singleton instance in the get_it locator
class Singleton extends DependencyRegistration {
  const Singleton({Type classType, Type asType, Function resolveUsing})
      : super(classType: classType, asType: asType, resolveUsing: resolveUsing);
}

/// Registers the type passed in as a LazySingleton instance in the get_it locator
class LazySingleton extends DependencyRegistration {
  const LazySingleton({Type classType, Type asType, Function resolveUsing})
      : super(classType: classType, asType: asType, resolveUsing: resolveUsing);
}

/// Registers the type passed in as a Factory in the get_it locator
class Factory extends DependencyRegistration {
  const Factory({Type classType, Type asType})
      : super(classType: classType, asType: asType);
}

/// Registers the type passed in to be presolved using the function passed in
class Presolve extends DependencyRegistration {
  /// The static instance Future function to use for resolving the type registered
  final Future Function() presolveUsing;

  const Presolve({Type classType, this.presolveUsing, Type asType})
      : super(classType: classType, asType: asType);
}
