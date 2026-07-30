import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/section_wrapper.dart';
import '../../data/portfolio_data.dart';

class AwardsSection extends StatelessWidget {
  const AwardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      id: SectionIds.awards,
      eyebrow: 'Recognition',
      title: 'Medals that mean something',
      subtitle:
          'From Climathon gold across Africa & the Middle East to Google Solution Challenge champion.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cols = constraints.maxWidth > 1000
              ? 3
              : constraints.maxWidth > 640
                  ? 2
                  : 1;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.awards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: cols == 1 ? 1.5 : 0.95,
            ),
            itemBuilder: (context, i) => _AwardCard(
              award: PortfolioData.awards[i],
              index: i,
            ),
          );
        },
      ),
    );
  }
}

class _AwardCard extends StatefulWidget {
  const _AwardCard({required this.award, required this.index});
  final Award award;
  final int index;

  @override
  State<_AwardCard> createState() => _AwardCardState();
}

class _AwardCardState extends State<_AwardCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  Color get _tierColor => switch (widget.award.tier) {
        AwardTier.gold => AppColors.gold,
        AwardTier.silver => AppColors.silver,
        AwardTier.honor => AppColors.accent,
      };

  IconData get _tierIcon => switch (widget.award.tier) {
        AwardTier.gold => Icons.workspace_premium_rounded,
        AwardTier.silver => Icons.military_tech_rounded,
        AwardTier.honor => Icons.verified_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final award = widget.award;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _confetti
          ..reset()
          ..forward();
      },
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -8.0 : 0.0, 0, 1),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _hovered
                ? _tierColor.withValues(alpha: 0.5)
                : AppColors.border,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _tierColor.withValues(alpha: _hovered ? 0.25 : 0.08),
              blurRadius: _hovered ? 36 : 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (_hovered)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _confetti,
                  builder: (context, _) => CustomPaint(
                    painter: _ConfettiPainter(
                      progress: _confetti.value,
                      color: _tierColor,
                    ),
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Medal
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _tierColor.withValues(alpha: 0.9),
                        _tierColor.withValues(alpha: 0.55),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _tierColor.withValues(alpha: 0.45),
                        blurRadius: _hovered ? 24 : 12,
                      ),
                    ],
                  ),
                  child: Icon(_tierIcon, color: Colors.white, size: 32),
                ),
                const Spacer(),
                Text(
                  award.place,
                  style: TextStyle(
                    color: _tierColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  award.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${award.event} · ${award.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  award.region,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;
    final rng = math.Random(21);
    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < 24; i++) {
      final x = rng.nextDouble() * size.width;
      final startY = size.height * 0.3;
      final y = startY - progress * (40 + rng.nextDouble() * 80);
      final opacity = (1 - progress).clamp(0.0, 1.0);
      paint.color = [
        color,
        AppColors.primary,
        AppColors.accent,
        AppColors.goldLight,
      ][i % 4]
          .withValues(alpha: opacity * 0.7);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * math.pi * 2 * (i.isEven ? 1 : -1));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: 4 + rng.nextDouble() * 4,
            height: 8 + rng.nextDouble() * 4,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
