import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

/// An implementation of the StackedView that allows you to use Hooks in the
/// build
abstract class StackedHook<T> extends HookWidget {
  final bool reactive;
  const StackedHook({Key? key, this.reactive = true});

  @override
  Widget build(BuildContext context) => builder(
        context,
        Provider.of<T>(context, listen: reactive),
      );

  Widget builder(BuildContext context, T model);
}
