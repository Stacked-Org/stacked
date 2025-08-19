import 'package:flutter/material.dart';

const Color _veryLightGrey = Color(0xFFE3E3E3);
const Color _lightGrey = Color(0xFF848B9E);

const int _transitionDuration = 500;

/// A widget that allows you to provide the expected UI and will render a shimmer over that
/// while loading is true.
class SkeletonLoader extends StatefulWidget {
  final bool loading;
  final Widget child;
  final Color startColor;
  final Color endColor;
  final Duration duration;
  final double cornerRadius;

  const SkeletonLoader({
    super.key,
    required this.child,
    required this.loading,
    this.duration = const Duration(seconds: 1),
    this.startColor = _veryLightGrey,
    this.endColor = _lightGrey,
    this.cornerRadius = 15.0,
  });

  @override
  SkeletonLoaderState createState() => SkeletonLoaderState();
}

class SkeletonLoaderState extends State<SkeletonLoader>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> animationOne;
  late Animation<Color?> animationTwo;

  Widget? _initialWidget;
  bool _transitionToNewWidget = false;
  bool _dispose = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Store the loading widget we first constructed with
    _initialWidget ??= widget.child;

    animationOne = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(_controller);
    animationTwo = ColorTween(begin: widget.endColor, end: widget.startColor)
        .animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if it's updated
    if (widget.child != _initialWidget && widget.loading) {
      // print('&^&^&^&^&   -     Widget UPDATED!!');
      // Indicate that we want to transition to a new widget

      _transitionToNewWidget = true;

      _initialWidget = widget.child;

      // Since the ShaderMask will still be rendered BUT the size
      // has now updated to match the actual data.
      // We will use a delayed future to only fade out the shader mask
      // a few milliseconds after we have received the actual widget.
      Future.delayed(const Duration(milliseconds: _transitionDuration))
          .then((value) {
        if (!_dispose) {
          setState(() {
            // print('&^&^&^&^&   -     Set widet transition to false!!');
            _transitionToNewWidget = false;
          });
        }
      });
    }

    return IgnorePointer(
      ignoring: widget.loading,
      child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          // We only want to show this if the widget is loading OR if the widget is busy with the transition.
          child: widget.loading || _transitionToNewWidget
              ? AnimatedSize(
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOut,
                  child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (rect) {
                      return LinearGradient(colors: [
                        animationOne.value!,
                        animationTwo.value!,
                      ]).createShader(rect);
                    },
                    child: CustomPaint(
                      foregroundPainter: RectangleFillPainter(
                          cornerRadius: widget.cornerRadius),
                      child: widget.child,
                    ),
                  ),
                )
              : widget.child),
    );
  }

  @override
  void dispose() {
    _dispose = true;
    _controller.dispose();
    super.dispose();
  }
}

class RectangleFillPainter extends CustomPainter {
  bool hasPainted = true;
  final double cornerRadius;

  RectangleFillPainter({required this.cornerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(cornerRadius),
        ),
        Paint()..color = Colors.grey);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (!hasPainted) {
      hasPainted = true;
      return true;
    }
    return false;
  }
}
