import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Soft custom cursor follower for desktop web.
class CustomCursorOverlay extends StatefulWidget {
  const CustomCursorOverlay({super.key, required this.child});

  final Widget child;

  @override
  State<CustomCursorOverlay> createState() => _CustomCursorOverlayState();
}

class _CustomCursorOverlayState extends State<CustomCursorOverlay>
    with SingleTickerProviderStateMixin {
  Offset _target = Offset.zero;
  Offset _current = Offset.zero;
  late final AnimationController _ticker;
  bool _visible = false;
  bool _isDesktop = false;

  @override
  void initState() {
    super.initState();
    _ticker = AnimationController.unbounded(vsync: this)
      ..addListener(() {
        setState(() {
          _current = Offset.lerp(_current, _target, 0.18)!;
        });
      });
    _ticker.repeat(min: 0, max: 1, period: const Duration(milliseconds: 16));
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isDesktop = MediaQuery.sizeOf(context).width >= 900;
    if (!_isDesktop) return widget.child;

    return MouseRegion(
      onHover: (e) {
        _target = e.position;
        if (!_visible) setState(() => _visible = true);
      },
      onExit: (_) => setState(() => _visible = false),
      child: Stack(
        children: [
          widget.child,
          if (_visible)
            Positioned(
              left: _current.dx - 18,
              top: _current.dy - 18,
              child: IgnorePointer(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.45),
                      width: 1.5,
                    ),
                    color: AppColors.primary.withValues(alpha: 0.06),
                  ),
                ),
              ),
            ),
          if (_visible)
            Positioned(
              left: _target.dx - 4,
              top: _target.dy - 4,
              child: IgnorePointer(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
