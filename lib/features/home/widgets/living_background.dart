import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Animated living mesh / aurora background.
class LivingBackground extends StatefulWidget {
  const LivingBackground({super.key, this.child});

  final Widget? child;

  @override
  State<LivingBackground> createState() => _LivingBackgroundState();
}

class _LivingBackgroundState extends State<LivingBackground>
    with TickerProviderStateMixin {
  late final AnimationController _slow;
  late final AnimationController _medium;
  late final AnimationController _particles;

  @override
  void initState() {
    super.initState();
    _slow = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat(reverse: true);
    _medium = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);
    _particles = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _slow.dispose();
    _medium.dispose();
    _particles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: Listenable.merge([_slow, _medium, _particles]),
      builder: (context, _) {
        final t = _slow.value;
        final m = _medium.value;
        final p = _particles.value;

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(color: AppColors.background),
            // Soft mesh blobs
            _blob(
              size,
              Alignment(-0.85 + t * 0.3, -0.9 + m * 0.2),
              420,
              AppColors.primary.withValues(alpha: 0.14),
            ),
            _blob(
              size,
              Alignment(0.9 - t * 0.25, -0.4 + t * 0.35),
              380,
              AppColors.secondary.withValues(alpha: 0.12),
            ),
            _blob(
              size,
              Alignment(-0.3 + m * 0.4, 0.7 - t * 0.2),
              460,
              AppColors.accent.withValues(alpha: 0.10),
            ),
            _blob(
              size,
              Alignment(0.6 - m * 0.3, 0.85),
              300,
              AppColors.highlight.withValues(alpha: 0.10),
            ),
            // Floating particles
            CustomPaint(
              size: size,
              painter: _ParticlePainter(progress: p),
            ),
            // Subtle noise overlay via gradient veil
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.25),
                  ],
                ),
              ),
            ),
            if (widget.child != null) widget.child!,
          ],
        );
      },
    );
  }

  Widget _blob(Size size, Alignment alignment, double diameter, Color color) {
    return Align(
      alignment: alignment,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rng = math.Random(42);

    for (var i = 0; i < 48; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final speed = 0.3 + rng.nextDouble() * 0.7;
      final radius = 1.2 + rng.nextDouble() * 2.4;
      final phase = rng.nextDouble();

      final y = (baseY + progress * size.height * speed) % (size.height + 40) - 20;
      final x = baseX + math.sin((progress + phase) * math.pi * 2) * 18;

      paint.color = [
        AppColors.primary,
        AppColors.secondary,
        AppColors.accent,
        AppColors.highlight,
      ][i % 4]
          .withValues(alpha: 0.18 + rng.nextDouble() * 0.22);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
