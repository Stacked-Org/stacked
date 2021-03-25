import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// A widget that provides a value passed through a provider as a parameter of the build function.
abstract class ViewModelWidget<T> extends Widget {
  final bool reactive;

  const ViewModelWidget({Key? key, this.reactive = true}) : super(key: key);

  @protected
  Widget build(BuildContext context, T viewModel);

  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T> extends ComponentElement {
  _DataProviderElement(ViewModelWidget widget) : super(widget);

  @override
  ViewModelWidget get widget => super.widget as ViewModelWidget<dynamic>;

  @override
  Widget build() =>
      widget.build(this, Provider.of<T>(this, listen: widget.reactive));

  @override
  void update(ViewModelWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
