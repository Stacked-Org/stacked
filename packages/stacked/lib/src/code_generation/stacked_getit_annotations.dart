import 'package:flutter/foundation.dart';

/// The class to describe a service registration on the get_it locator
class DependencyRegistration {
  /// The type of the service to register
  final Type service;

  const DependencyRegistration({@required this.service});
}

/// Registers the type passed in as a singleton instance in the get_it locator
class Singleton extends DependencyRegistration {
  const Singleton({@required Type service}) : super(service: service);
}

/// Registers the type passed in as a LazySingleton instance in the get_it locator
class LazySingleton extends DependencyRegistration {
  const LazySingleton({@required Type service}) : super(service: service);
}

/// Registers the type passed in as a Factory in the get_it locator
class Factory extends DependencyRegistration {
  const Factory({@required Type service}) : super(service: service);
}

/// Registers the type passed in to be presolved using the function passed in
class Presolve extends DependencyRegistration {
  final Future Function() presolveUsing;

  const Presolve({@required Type service, @required this.presolveUsing})
      : super(service: service);
}
