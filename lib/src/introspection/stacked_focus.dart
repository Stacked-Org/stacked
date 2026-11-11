import 'package:flutter/widgets.dart';
import 'package:stacked/src/introspection/view_model_registry.dart';
import 'package:stacked_shared/stacked_introspection.dart';

/// Finds the ViewModel the user is looking at and describes it, together with
/// what can be done on it.
abstract final class StackedFocus {
  /// The focused node with children, lent actions and overlay filled in.
  ///
  /// When no ViewModel is on screen the node is named `(none)`.
  static StackedNode node() {
    final introspector = StackedIntrospector.instance;

    final candidates = [
      for (final entry in ViewModelRegistry.instance.mounted)
        if (_isVisible(entry.context) && _isCurrentRoute(entry.context)) entry,
    ];

    var screens = [
      for (final entry in candidates)
        if (_isScreenKind(introspector.kindOf(entry.viewModel))) entry,
    ];
    // No StackedView page is showing, such as a page that builds its own
    // ViewModelBuilder. The outermost ViewModel on the current route is
    // that page's ViewModel.
    final promoted = screens.isEmpty;
    if (promoted) {
      screens = [
        for (final entry in candidates)
          if (!candidates.any((other) =>
              !identical(other, entry) &&
              _hasAncestor(entry.context, other.context as Element)))
            entry,
      ];
    }

    if (screens.isEmpty) {
      return const StackedNode(
        name: '(none)',
        kind: NodeKind.widget,
        warnings: ['No ViewModel is on screen.'],
      );
    }

    var focused = screens.first;
    for (final entry in screens.skip(1)) {
      final depth = _depth(entry.context);
      final focusedDepth = _depth(focused.context);
      if (depth > focusedDepth ||
          (depth == focusedDepth && entry.order > focused.order)) {
        focused = entry;
      }
    }

    final base = introspector.describe(focused.viewModel);
    final routeName = ModalRoute.of(focused.context)?.settings.name;

    final focusedElement = focused.context as Element;
    final childEntries = [
      for (final entry in candidates)
        if (!identical(entry, focused) &&
            _hasAncestor(entry.context, focusedElement))
          entry,
    ]..sort((a, b) {
        final byDepth = _depth(a.context).compareTo(_depth(b.context));
        return byDepth != 0 ? byDepth : a.order.compareTo(b.order);
      });
    final children = [
      for (final entry in childEntries) introspector.describe(entry.viewModel),
    ];

    final lent = <ActionSpec>[];
    final navigator = Navigator.maybeOf(focused.context);
    if (navigator != null && navigator.canPop()) {
      lent.add(
        ActionSpec(
          name: 'goBack',
          from: 'navigator',
          invoke: (_) async {
            await navigator.maybePop();
          },
        ),
      );
    }

    final providers = LentActionProviders.active;
    for (final provider in providers) {
      for (final action in provider.actions) {
        lent.add(action.copyWith(from: provider.id));
      }
    }

    Map<String, Object?>? overlay;
    for (final provider in providers) {
      final value = provider.overlay;
      if (value != null) {
        overlay = value;
        break;
      }
    }

    return base.copyWith(
      kind: promoted && ModalRoute.of(focused.context) is PageRoute
          ? NodeKind.route
          : null,
      route: routeName,
      children: children,
      lent: lent,
      overlay: overlay,
    );
  }

  /// Resolves [action] on a freshly built [node], normalizes [rawInput] with
  /// the action's params and calls its invoker.
  ///
  /// Throws [ActionNotFound], [ActionUnsupported] or [ActionInputException]
  /// synchronously, before any invoker runs.
  static Future<void> invoke(String action, [Object? rawInput]) {
    final node = StackedFocus.node();
    final resolved = ActionResolver.resolve(node, action);
    final input = ActionInput.normalize(rawInput, resolved.spec.params);
    return Future.sync(() => resolved.spec.invoke!(input));
  }

  static bool _isScreenKind(NodeKind? kind) =>
      kind == NodeKind.route ||
      kind == NodeKind.dialog ||
      kind == NodeKind.sheet;

  static int _depth(BuildContext context) => (context as Element).depth;

  static bool _isCurrentRoute(BuildContext context) {
    final route = ModalRoute.of(context);
    return route == null || route.isCurrent;
  }

  static bool _isVisible(BuildContext context) {
    var visible = true;
    context.visitAncestorElements((element) {
      final widget = element.widget;
      if ((widget is Offstage && widget.offstage) ||
          (widget is TickerMode && !widget.enabled) ||
          (widget is Visibility && !widget.visible)) {
        visible = false;
        return false;
      }
      return true;
    });
    return visible;
  }

  static bool _hasAncestor(BuildContext context, Element ancestor) {
    var found = false;
    context.visitAncestorElements((element) {
      if (identical(element, ancestor)) {
        found = true;
        return false;
      }
      return true;
    });
    return found;
  }
}
