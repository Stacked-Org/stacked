import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const Color _veryLightGrey = Color(0xFFE3E3E3);
const Color _lightGrey = Color(0xFF848B9E);

const int _TransitionDuration = 500;

/// A widget that allows you to provide the expected UI and will render a shimmer over that
/// while loading is true.
class SkeletonLoader extends StatefulWidget {
  final bool loading;
  final Widget child;
  final Color startColor;
  final Color endColor;
  final Duration duration;
  final double borderRadius;
  final double? width;
  final double? height;
  final double? widthFactor;
  const SkeletonLoader({
    Key? key,
    required this.loading,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.startColor = _veryLightGrey,
    this.endColor = _lightGrey,
    this.borderRadius = 5.0,
    this.width,
    this.height,
    this.widthFactor,
  }) : super(key: key);

  @override
  _SkeletonLoaderState createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState<T> extends State<SkeletonLoader>
    with TickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late Animation<Color?> animationOne;
  late Animation<Color?> animationTwo;

  Widget? _initialWidget;
  bool _transitionToNewWidget = false;
  bool _dispose = false;

  @override
  void initState() {
    super.initState();

    // Store the loading widget we first constructed with
    if (_initialWidget == null) {
      _initialWidget = widget.child;
    }

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
      // Indicate that we want to transition to a new widget
      _transitionToNewWidget = true;

      _initialWidget = widget.child;

      // Since the ShaderMask will still be rendered BUT the size
      // has now updated to match the actual data.
      // We will use a delayed future to only fade out the shader mask
      // a few milliseconds after we have received the actual widget.
      Future.delayed(Duration(milliseconds: _TransitionDuration)).then((value) {
        if (!_dispose) {
          setState(() {
            // print('&^&^&^&^&   -     Set widet transition to false!!');
            _transitionToNewWidget = false;
          });
        }
      });
    }

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.centerLeft,
      crossFadeState: widget.loading || _transitionToNewWidget
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: ShaderMask(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: FractionallySizedBox(
            widthFactor: widget.widthFactor,
            child: CustomPaint(
              // child: widget.child,
              foregroundPainter: RectangleFillPainter(widget.borderRadius),
            ),
          ),
        ),
        blendMode: BlendMode.srcATop,
        shaderCallback: (rect) {
          return LinearGradient(
            colors: [
              animationOne.value!,
              animationTwo.value!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(rect);
        },
      ),
      secondChild: Container(
        constraints: BoxConstraints(minWidth: 50),
        child: widget.child,
      ),
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
  final double borderRadius;
  RectangleFillPainter(this.borderRadius);

  bool hasPainted = true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
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
