import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/section_wrapper.dart';
import '../../data/portfolio_data.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbit;
  String? _hovered;

  @override
  void initState() {
    super.initState();
    _orbit = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _orbit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      id: SectionIds.skills,
      eyebrow: 'Capabilities',
      title: 'A living tech universe',
      subtitle:
          'Not progress bars — an interactive constellation of the tools I craft with every day.',
      child: Column(
        children: [
          // Orbit visualization
          SizedBox(
            height: context.responsive(mobile: 320, tablet: 400, desktop: 460),
            child: AnimatedBuilder(
              animation: _orbit,
              builder: (context, _) {
                return CustomPaint(
                  painter: _OrbitRingsPainter(progress: _orbit.value),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Core
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryGradient,
                          boxShadow: AppColors.glowShadow(AppColors.primary),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'HE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      ..._buildOrbitingSkills(context),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 48),
          // Category cards
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = constraints.maxWidth > 900
                  ? 4
                  : constraints.maxWidth > 560
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PortfolioData.skillCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 1.6 : 0.95,
                ),
                itemBuilder: (context, i) {
                  final cat = PortfolioData.skillCategories[i];
                  return GlassCard(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: cat.skills.map((s) {
                              return _SkillBubble(
                                skill: s,
                                highlighted: _hovered == s.name,
                                onHover: (v) => setState(
                                  () => _hovered = v ? s.name : null,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 32),
          // Tech cloud
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: PortfolioData.techStack.map((tech) {
              final active = _hovered == tech;
              return MouseRegion(
                onEnter: (_) => setState(() => _hovered = tech),
                onExit: (_) => setState(() => _hovered = null),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  transform: Matrix4.identity()
                    ..scaleByDouble(
                      active ? 1.08 : 1.0,
                      active ? 1.08 : 1.0,
                      1,
                      1,
                    ),
                  decoration: BoxDecoration(
                    gradient: active ? AppColors.primaryGradient : null,
                    color: active ? null : Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: active
                          ? Colors.transparent
                          : AppColors.border,
                    ),
                    boxShadow: active
                        ? AppColors.glowShadow(AppColors.primary)
                        : AppColors.cardShadow,
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: active ? Colors.white : AppColors.text,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOrbitingSkills(BuildContext context) {
    final skills = PortfolioData.techStack.take(12).toList();
    final size = MediaQuery.sizeOf(context);
    final base = math.min(size.width * 0.35, 200.0);

    return List.generate(skills.length, (i) {
      final ring = i < 6 ? 0 : 1;
      final count = ring == 0 ? 6 : 6;
      final indexInRing = ring == 0 ? i : i - 6;
      final radius = base * (0.55 + ring * 0.45);
      final angle = _orbit.value * math.pi * 2 * (ring == 0 ? 1 : -0.7) +
          (indexInRing * math.pi * 2 / count);
      final x = math.cos(angle) * radius;
      final y = math.sin(angle) * radius * 0.72;
      final skill = skills[i];
      final active = _hovered == skill;

      return Transform.translate(
        offset: Offset(x, y),
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = skill),
          onExit: (_) => setState(() => _hovered = null),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: active ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: active
                    ? AppColors.primary
                    : AppColors.border,
              ),
              boxShadow: active
                  ? AppColors.glowShadow(AppColors.primary)
                  : AppColors.cardShadow,
            ),
            child: Text(
              skill,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: active ? Colors.white : AppColors.text,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _SkillBubble extends StatelessWidget {
  const _SkillBubble({
    required this.skill,
    required this.highlighted,
    required this.onHover,
  });

  final Skill skill;
  final bool highlighted;
  final void Function(bool) onHover;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: highlighted
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: highlighted
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: CustomPaint(
                painter: _ArcPainter(
                  progress: skill.level,
                  color: highlighted ? AppColors.primary : AppColors.secondary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              skill.name,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    final bg = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bg);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      progress * math.pi * 2,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

class _OrbitRingsPainter extends CustomPainter {
  _OrbitRingsPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 1; i <= 3; i++) {
      paint.color = AppColors.primary.withValues(alpha: 0.08 + i * 0.03);
      final r = math.min(size.width, size.height) * 0.12 * i + 40;
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: r * 2,
          height: r * 1.45,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitRingsPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
