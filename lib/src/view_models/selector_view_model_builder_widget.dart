import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class SelectorViewModelWidget<T extends ChangeNotifier, K>
    extends Widget {
  const SelectorViewModelWidget({Key? key}) : super(key: key);

  K selector(T viewModel);
  Widget? get staticChild => null;
  bool shouldRebuild(K v1, K v2) => v1 != v2;
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
      selector: (BuildContext context, T viewModel) =>
          widget.selector(viewModel),
      builder: (BuildContext _, K value, Widget? child) =>
          widget.build(this, value),
      child: widget.staticChild,
    );
  }

  @override
  void update(SelectorViewModelWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
