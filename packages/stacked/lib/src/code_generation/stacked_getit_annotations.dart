/// The class to describe a service registration on the get_it locator
class DependencyRegistration {
  /// The type of the service to register
  final Type service;

  const DependencyRegistration({this.service});
}

/// Registers the type passed in as a singleton instance in the get_it locator
class Singleton extends DependencyRegistration {
  const Singleton({Type service}) : super(service: service);
}

/// Registers the type passed in as a LazySingleton instance in the get_it locator
class LazySingleton extends DependencyRegistration {
  const LazySingleton({Type service}) : super(service: service);
}

/// Registers the type passed in as a Factory in the get_it locator
class Factory extends DependencyRegistration {
  const Factory({Type service}) : super(service: service);
}

/// Registers the type passed in to be presolved using the function passed in
class Presolve extends DependencyRegistration {
  final Future Function() presolveUsing;

  const Presolve({Type service, this.presolveUsing}) : super(service: service);
}
