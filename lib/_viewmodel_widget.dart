import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

/// A widget that provides a value passed through a provider as a parameter of the build function.
abstract class ViewModelWidget<T> extends Widget {
  final bool reactive;

  ViewModelWidget({Key key, this.reactive = true}) : super(key: key);

  @protected
  Widget build(BuildContext context, T viewModel);

  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T> extends ComponentElement {
  _DataProviderElement(ViewModelWidget widget) : super(widget);

  @override
  ViewModelWidget get widget => super.widget;

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

/// An implementation of the ViewModelWidget that allows you to use Hooks in the build
abstract class HookViewModelWidget<T> extends HookWidget {
  final bool reactive;
  HookViewModelWidget({this.reactive = true});

  @override
  Widget build(BuildContext context) =>
      buildViewModelWidget(context, Provider.of<T>(context, listen: reactive));

  Widget buildViewModelWidget(BuildContext context, T viewModel);
}
