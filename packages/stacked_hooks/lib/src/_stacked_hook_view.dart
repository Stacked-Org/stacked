import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

@Deprecated(
    'This widget will be removed by March 2023, please use the StackedHookView instead')
abstract class HookViewModelWidget<T> extends StackedHookView<T> {
  const HookViewModelWidget({Key? key, super.reactive = true});
}

/// An implementation of the StackedView that allows you to use Hooks in the
/// build
abstract class StackedHookView<T> extends HookWidget {
  final bool reactive;
  const StackedHookView({Key? key, this.reactive = true});

  @override
  Widget build(BuildContext context) => builder(
        context,
        Provider.of<T>(context, listen: reactive),
      );

  Widget builder(BuildContext context, T model);
}
