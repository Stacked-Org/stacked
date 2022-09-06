import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final void Function(DialogResponse) completer;
  const BasicDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
