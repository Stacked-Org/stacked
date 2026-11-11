import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A ViewModel that is currently owned by a mounted widget.
class ViewModelRegistration {
  const ViewModelRegistration(this.viewModel, this.context, this.order);

  final Object viewModel;
  final BuildContext context;

  /// Increasing registration counter.
  final int order;
}

/// Tracks the ViewModels that are alive in the widget tree so that
/// [StackedFocus] can find the one the user is looking at.
class ViewModelRegistry {
  ViewModelRegistry._();

  static final ViewModelRegistry instance = ViewModelRegistry._();

  /// Defaults to `!kReleaseMode`. When false, [register] does nothing.
  static bool enabled = !kReleaseMode;

  final Map<State, ViewModelRegistration> _entries = {};
  int _counter = 0;

  /// Registers [viewModel], keyed by [owner].
  void register(State owner, Object viewModel, BuildContext context) {
    if (!enabled) return;
    _entries[owner] = ViewModelRegistration(viewModel, context, _counter++);
  }

  void unregister(State owner) {
    _entries.remove(owner);
  }

  /// Entries whose context is mounted, in registration order.
  List<ViewModelRegistration> get mounted => [
        for (final entry in _entries.values)
          if (entry.context.mounted) entry,
      ]..sort((a, b) => a.order.compareTo(b.order));

  void reset() => _entries.clear();
}
