import 'package:flutter/material.dart';
import 'package:stacked/src/router/common/route_wrapper.dart';

@optionalTypeArgs
class WrappedRoute<T extends RouteWrapper> extends StatelessWidget {
  const WrappedRoute({super.key, required this.child});
  final T child;

  @override
  Widget build(BuildContext context) {
    return child.wrappedRoute(context);
  }
}
