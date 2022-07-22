import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class SelectorViewModelWidget<T extends ChangeNotifier, K>
    extends Widget {
  const SelectorViewModelWidget({
    required this.selector,
    required this.builder,
    this.child,
    this.shouldRebuild,
    Key? key,
  }) : super(key: key);

  final K Function(T model) selector;
  final Widget Function(BuildContext context, K value) builder;
  final Widget? child;
  final bool Function(K, K)? shouldRebuild;
  @protected
  Widget build(BuildContext context, K value);

  @override
  _DataProviderElement<T, K> createElement() =>
      _DataProviderElement<T, K>(this);
}

class _DataProviderElement<T extends ChangeNotifier, K>
    extends ComponentElement {
  _DataProviderElement(SelectorViewModelWidget widget) : super(widget);

  @override
  SelectorViewModelWidget get widget =>
      super.widget as SelectorViewModelWidget<T, K>;

  @override
  Widget build() {
    return Selector<T, K>(
      key: widget.key,
      shouldRebuild: widget.shouldRebuild,
      selector: (BuildContext context, T model) => widget.selector(model),
      builder: (BuildContext _, K value, Widget? child) =>
          widget.build(this, value),
      child: widget.child,
    );
  }

  @override
  void update(SelectorViewModelWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
