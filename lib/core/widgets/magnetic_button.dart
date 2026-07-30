import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MagneticButton extends StatefulWidget {
  const MagneticButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.filled = true,
    this.gradient = true,
    this.padding,
    this.fontSize = 14,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool filled;
  final bool gradient;
  final EdgeInsetsGeometry? padding;
  final double fontSize;

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Offset _offset = Offset.zero;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final delta = event.localPosition - center;
    setState(() {
      _hovered = true;
      _offset = Offset(delta.dx * 0.18, delta.dy * 0.18);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) => setState(() {
        _hovered = false;
        _offset = Offset.zero;
      }),
      cursor: SystemMouseCursors.click,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MouseRegion(
            onHover: (e) => _onHover(
              e,
              Size(
                constraints.maxWidth.isFinite ? constraints.maxWidth : 160,
                52,
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              transform: Matrix4.identity()
                ..translateByDouble(_offset.dx, _offset.dy, 0, 1)
                ..scaleByDouble(
                  _hovered ? 1.04 : 1.0,
                  _hovered ? 1.04 : 1.0,
                  1,
                  1,
                ),
              child: GestureDetector(
                onTap: widget.onTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: widget.padding ??
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: widget.filled && widget.gradient
                        ? AppColors.primaryGradient
                        : null,
                    color: widget.filled
                        ? (widget.gradient ? null : AppColors.primary)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: widget.filled
                        ? null
                        : Border.all(
                            color: _hovered
                                ? AppColors.primary
                                : AppColors.border,
                            width: 1.5,
                          ),
                    boxShadow: widget.filled && _hovered
                        ? AppColors.glowShadow(AppColors.primary)
                        : widget.filled
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.25),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 18,
                          color: widget.filled
                              ? Colors.white
                              : AppColors.primary,
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w600,
                          color: widget.filled
                              ? Colors.white
                              : AppColors.text,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
