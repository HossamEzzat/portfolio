import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/launch_utils.dart';
import '../../core/utils/responsive.dart';
import '../../core/constants/app_constants.dart';
import '../../data/portfolio_data.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.onNavigate});

  final void Function(String sectionId) onNavigate;

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.horizontalPadding,
        vertical: 48,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            AppColors.primary.withValues(alpha: 0.04),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: AppColors.glowShadow(AppColors.primary),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'HE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: 2400.ms,
                  ),
              const SizedBox(height: 20),
              Text(
                PortfolioData.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              Text(
                '${PortfolioData.title} · ${PortfolioData.role}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ('Home', SectionIds.home),
                  ('About', SectionIds.about),
                  ('Projects', SectionIds.projects),
                  ('Awards', SectionIds.awards),
                  ('Contact', SectionIds.contact),
                ]
                    .map(
                      (item) => TextButton(
                        onPressed: () => onNavigate(item.$2),
                        child: Text(
                          item.$1,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => openUrl('${PortfolioData.resumeUrl}'),
                icon: const Icon(Icons.download_rounded, size: 16),
                label: const Text('Download Resume'),
              ),
              const SizedBox(height: 32),
              Container(height: 1, color: AppColors.border),
              const SizedBox(height: 24),
              Text(
                '© $year ${PortfolioData.name}. Crafted with Flutter — designed to be unforgettable.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
