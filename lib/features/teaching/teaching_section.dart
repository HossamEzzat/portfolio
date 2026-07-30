import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/animated_counter.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/section_wrapper.dart';
import '../../data/portfolio_data.dart';

class TeachingSection extends StatelessWidget {
  const TeachingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      id: SectionIds.teaching,
      eyebrow: 'Teaching',
      title: 'Shaping the next Flutter generation',
      subtitle:
          '200+ students across 7 academies — practical projects, competition mentoring, and real-world craft.',
      child: Column(
        children: [
          // Hero teaching stats
          GlassCard(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsive(mobile: 24, desktop: 48),
              vertical: context.responsive(mobile: 32, desktop: 40),
            ),
            borderRadius: 28,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.08),
                AppColors.accent.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.9),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      AnimatedCounter(
                        value: 200,
                        suffix: '+',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Students Mentored',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 64,
                  color: AppColors.border,
                ),
                Expanded(
                  child: Column(
                    children: [
                      AnimatedCounter(
                        value: 7,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Academies',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          // Academy cards
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 560
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PortfolioData.academies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 3.2 : 2.2,
                ),
                itemBuilder: (context, i) => _AcademyCard(
                  name: PortfolioData.academies[i],
                  index: i,
                ),
              );
            },
          ),
          const SizedBox(height: 36),
          // What I teach
          GlassCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What I deliver',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                ...[
                  (
                    Icons.code_rounded,
                    'Flutter & Dart Fundamentals → Production Apps'
                  ),
                  (
                    Icons.architecture_rounded,
                    'Clean Architecture & State Management Mastery'
                  ),
                  (
                    Icons.emoji_events_outlined,
                    'Competition Mentoring & Project Reviews'
                  ),
                  (
                    Icons.handyman_outlined,
                    'Real-world Projects & Practical Materials'
                  ),
                ].map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(item.$1, color: AppColors.primary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item.$2,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AcademyCard extends StatefulWidget {
  const _AcademyCard({required this.name, required this.index});
  final String name;
  final int index;

  @override
  State<_AcademyCard> createState() => _AcademyCardState();
}

class _AcademyCardState extends State<_AcademyCard> {
  bool _hovered = false;

  static const _colors = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.accent,
    AppColors.highlight,
    AppColors.success,
    AppColors.gold,
    Color(0xFFEC4899),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[widget.index % _colors.length];
    final initials = widget.name
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0])
        .join();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -4.0 : 0.0, 0, 1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? color.withValues(alpha: 0.4) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ]
              : AppColors.cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                widget.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
