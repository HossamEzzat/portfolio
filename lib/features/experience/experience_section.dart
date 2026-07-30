import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/section_wrapper.dart';
import '../../data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      id: SectionIds.experience,
      eyebrow: 'Experience',
      title: 'Where craft meets product',
      subtitle:
          'From enterprise HR platforms to mentoring the next wave of Flutter engineers.',
      child: Column(
        children: List.generate(PortfolioData.experiences.length, (i) {
          return _ExperienceCard(
            experience: PortfolioData.experiences[i],
            index: i,
            isLast: i == PortfolioData.experiences.length - 1,
          );
        }),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({
    required this.experience,
    required this.index,
    required this.isLast,
  });

  final Experience experience;
  final int index;
  final bool isLast;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  static const _typeColors = {
    'Full-time': AppColors.primary,
    'Part-time': AppColors.secondary,
    'Teaching': AppColors.accent,
  };

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    final color = _typeColors[exp.type] ?? AppColors.primary;
    final isDesktop = context.isDesktop;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) ...[
            SizedBox(
              width: 120,
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Text(
                  exp.period,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 32),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _hovered ? 20 : 14,
                  height: _hovered ? 20 : 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.45),
                        blurRadius: _hovered ? 16 : 8,
                      ),
                    ],
                  ),
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 24),
          ],
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 20),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  transform: Matrix4.identity()
                    ..translateByDouble(_hovered ? 6.0 : 0.0, 0.0, 0, 1),
                  child: GlassCard(
                    padding: const EdgeInsets.all(28),
                    borderRadius: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                exp.type,
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            if (!isDesktop) ...[
                              const Spacer(),
                              Text(
                                exp.period,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: AppColors.primary),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          exp.role,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          exp.company,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        ...exp.highlights.map(
                          (h) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 7),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    h,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
