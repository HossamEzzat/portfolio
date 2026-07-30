import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/animated_counter.dart';
import '../../core/widgets/glass_card.dart';
import '../../data/portfolio_data.dart';
import '../../core/utils/responsive.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.horizontalPadding,
        vertical: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: GlassCard(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsive(mobile: 16, tablet: 24, desktop: 32),
              vertical: context.responsive(mobile: 28, tablet: 36, desktop: 40),
            ),
            borderRadius: 28,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cols = constraints.maxWidth > 900
                    ? 6
                    : constraints.maxWidth > 560
                        ? 3
                        : 2;
                return Wrap(
                  spacing: 8,
                  runSpacing: 24,
                  alignment: WrapAlignment.spaceEvenly,
                  children: PortfolioData.stats.map((stat) {
                    return SizedBox(
                      width: (constraints.maxWidth - 48) / cols,
                      child: Column(
                        children: [
                          AnimatedCounter(
                            value: stat.value,
                            suffix: stat.suffix,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontSize: 36),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            stat.label,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
