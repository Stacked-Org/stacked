import 'package:flutter/material.dart';

class ScaleOnHover extends StatefulWidget {
  final double scale;
  final Widget child;
  // You can also pass the translation in here if you want to
  const ScaleOnHover({super.key, required this.child, this.scale = 1.1});

  @override
  _ScaleOnHoverState createState() => _ScaleOnHoverState();
}

class _ScaleOnHoverState extends State<ScaleOnHover> {
  final scaleTransform = Matrix4.identity()..scale(1.1);
  final noScaleTransform = Matrix4.identity()..scale(1.0);

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCirc,
        child: widget.child,
        transform: _hovering ? scaleTransform : noScaleTransform,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
