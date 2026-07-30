import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/magnetic_button.dart';
import '../../../data/portfolio_data.dart';

class FloatingNav extends StatelessWidget {
  const FloatingNav({
    super.key,
    required this.scrolled,
    required this.onNavigate,
    required this.onHire,
    this.activeSection = SectionIds.home,
  });

  final bool scrolled;
  final void Function(String sectionId) onNavigate;
  final VoidCallback onHire;
  final String activeSection;

  static const _items = [
    ('Home', SectionIds.home),
    ('About', SectionIds.about),
    ('Experience', SectionIds.experience),
    ('Projects', SectionIds.projects),
    ('Teaching', SectionIds.teaching),
    ('Awards', SectionIds.awards),
    ('Skills', SectionIds.skills),
    ('Contact', SectionIds.contact),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile || context.screenWidth < 1100;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      margin: EdgeInsets.symmetric(
        horizontal: context.responsive(mobile: 12, tablet: 24, desktop: 32),
        vertical: scrolled ? 12 : 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 20,
              vertical: isMobile ? 10 : 12,
            ),
            decoration: BoxDecoration(
              color: scrolled
                  ? Colors.white.withValues(alpha: 0.92)
                  : Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: scrolled
                    ? AppColors.border.withValues(alpha: 0.8)
                    : Colors.white.withValues(alpha: 0.7),
              ),
              boxShadow: scrolled
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : AppColors.softShadow,
            ),
            child: Row(
              children: [
                _Logo(onTap: () => onNavigate(SectionIds.home)),
                const Spacer(),
                if (!isMobile)
                  ..._items.map(
                    (item) => _NavItem(
                      label: item.$1,
                      active: activeSection == item.$2,
                      onTap: () => onNavigate(item.$2),
                    ),
                  ),
                if (!isMobile) ...[
                  const SizedBox(width: 12),
                  MagneticButton(
                    label: 'Hire Me',
                    onTap: onHire,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    fontSize: 13,
                  ),
                ],
                if (isMobile)
                  IconButton(
                    onPressed: () => _openDrawer(context),
                    icon: const Icon(Icons.menu_rounded),
                    color: AppColors.text,
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.4, end: 0);
  }

  void _openDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 24),
                ..._items.map(
                  (item) => ListTile(
                    title: Text(
                      item.$1,
                      style: TextStyle(
                        fontWeight: activeSection == item.$2
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: activeSection == item.$2
                            ? AppColors.primary
                            : AppColors.text,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      onNavigate(item.$2);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: MagneticButton(label: 'Hire Me', onTap: () {
                    Navigator.pop(ctx);
                    onHire();
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'HE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            if (context.screenWidth > 420) ...[
              const SizedBox(width: 12),
              Text(
                PortfolioData.shortName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.onTap,
    required this.active,
  });

  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hovered;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: highlighted ? FontWeight.w700 : FontWeight.w500,
                  color: highlighted ? AppColors.primary : AppColors.textSecondary,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: highlighted ? 16 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
