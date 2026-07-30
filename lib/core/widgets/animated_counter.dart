import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_colors.dart';

class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    this.suffix = '',
    this.duration = const Duration(milliseconds: 1800),
    this.style,
  });

  final int value;
  final String suffix;
  final Duration duration;
  final TextStyle? style;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    if (_started) return;
    _started = true;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('counter-${widget.value}-${widget.suffix}-${widget.hashCode}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3) _start();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final current = (_animation.value * widget.value).round();
          return ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: Text(
              '$current${widget.suffix}',
              style: (widget.style ??
                      Theme.of(context).textTheme.displaySmall)
                  ?.copyWith(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
