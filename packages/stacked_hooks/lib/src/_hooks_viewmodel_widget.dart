import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

/// An implementation of the ViewModelWidget that allows you to use Hooks in the build
abstract class HookViewModelWidget<T> extends HookWidget {
  final bool reactive;
  const HookViewModelWidget({Key? key, this.reactive = true});

  @override
  Widget build(BuildContext context) =>
      buildViewModelWidget(context, Provider.of<T>(context, listen: reactive));

  Widget buildViewModelWidget(BuildContext context, T viewModel);
}
