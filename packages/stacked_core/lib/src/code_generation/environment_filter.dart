/// a simple filter function to be used inside [SimpleEnvironmentFilter]
typedef EnvironmentFilterFunc = bool Function(Set<String>);
const kEnvironmentsName = '__environments__';

/// filter for whether to register for the given set of environments
/// clients can extend this class to maker
/// their own environmentFilters
abstract class EnvironmentFilter {
  /// holds passed environment keys
  /// to be used inside the filter or
  /// retrieved later by users
  final Set<String?> environments;

  /// default constructor
  const EnvironmentFilter(this.environments);

  /// This function is called before every
  /// registration call, if it returns true, the dependency
  /// will be registered otherwise, it will be ignored
  bool canRegister(Set<String> depEnvironments);
}

///  A simple filter that can be used directly for simple use cases
///  without having to extend the base [EnvironmentFilter]
class SimpleEnvironmentFilter extends EnvironmentFilter {
  final EnvironmentFilterFunc filter;

  const SimpleEnvironmentFilter(
      {required this.filter, Set<String> environments = const {}})
      : super(environments);

  @override
  bool canRegister(Set<String> depEnvironments) => filter(depEnvironments);
}

/// This filter validates dependencies with no environment
/// keys or contain the provided [environment]
class NoEnvOrContains extends EnvironmentFilter {
  NoEnvOrContains(String? environment) : super({environment});

  @override
  bool canRegister(Set<String> depEnvironments) {
    return (depEnvironments.isEmpty) ||
        depEnvironments.contains(environments.first);
  }
}

/// This filter validates dependencies with no environment
/// keys, or the ones containing all the provided [environments]
class NoEnvOrContainsAll extends EnvironmentFilter {
  const NoEnvOrContainsAll(Set<String> environments) : super(environments);

  @override
  bool canRegister(Set<String> depEnvironments) {
    return (depEnvironments.isEmpty) ||
        depEnvironments.containsAll(environments);
  }
}

/// This filter validates dependencies with no environment
/// keys, or the ones containing one of the provided [environments]
class NoEnvOrContainsAny extends EnvironmentFilter {
  const NoEnvOrContainsAny(Set<String> environments) : super(environments);

  @override
  bool canRegister(Set<String> depEnvironments) {
    return (depEnvironments.isEmpty) ||
        depEnvironments.intersection(environments).isNotEmpty;
  }
}
