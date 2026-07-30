import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/launch_utils.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/magnetic_button.dart';
import '../../data/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.onNavigate,
  });

  final void Function(String sectionId) onNavigate;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _float;
  late final AnimationController _halo;
  late final AnimationController _typewriter;
  int _roleIndex = 0;
  String _displayed = '';
  bool _deleting = false;
  Offset _mouse = Offset.zero;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _halo = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _typewriter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _tickTypewriter();
          _typewriter
            ..reset()
            ..forward();
        }
      });
    _displayed = '';
    _typewriter.forward();
  }

  void _tickTypewriter() {
    final roles = PortfolioData.typingRoles;
    final full = roles[_roleIndex];

    if (!_deleting) {
      if (_displayed.length < full.length) {
        setState(() => _displayed = full.substring(0, _displayed.length + 1));
      } else {
        Future.delayed(const Duration(milliseconds: 1400), () {
          if (mounted) setState(() => _deleting = true);
        });
      }
    } else {
      if (_displayed.isNotEmpty) {
        setState(
          () => _displayed = _displayed.substring(0, _displayed.length - 1),
        );
      } else {
        setState(() {
          _deleting = false;
          _roleIndex = (_roleIndex + 1) % roles.length;
        });
      }
    }
  }

  @override
  void dispose() {
    _float.dispose();
    _halo.dispose();
    _typewriter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final pad = context.horizontalPadding;

    return MouseRegion(
      onHover: (e) {
        final size = MediaQuery.sizeOf(context);
        setState(() {
          _mouse = Offset(
            (e.position.dx / size.width - 0.5) * 2,
            (e.position.dy / size.height - 0.5) * 2,
          );
        });
      },
      child: Container(
        key: const Key(SectionIds.home),
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          pad,
          context.responsive(mobile: 120, tablet: 140, desktop: 160),
          pad,
          context.responsive(mobile: 64, tablet: 80, desktop: 100),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 11, child: _buildCopy(context)),
                      const SizedBox(width: 48),
                      Expanded(flex: 9, child: _buildPortrait(context)),
                    ],
                  )
                : Column(
                    children: [
                      _buildPortrait(context),
                      const SizedBox(height: 48),
                      _buildCopy(context),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildCopy(BuildContext context) {
    return Column(
      crossAxisAlignment: context.isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fade(begin: 0.4, end: 1, duration: 900.ms),
              const SizedBox(width: 8),
              Text(
                'Available for new opportunities',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 28),
        Text(
          'Hello, I\'m',
          textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.25, end: 0),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.text,
              AppColors.primary,
              AppColors.accent,
            ],
          ).createShader(bounds),
          child: Text(
            PortfolioData.name,
            textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: context.responsive(
                    mobile: 36,
                    tablet: 48,
                    desktop: 56,
                  ),
                  color: Colors.white,
                ),
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 180.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 16),
        SizedBox(
          height: 36,
          child: Row(
            mainAxisAlignment: context.isDesktop
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Text(
                _displayed,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Container(
                width: 2,
                height: 22,
                margin: const EdgeInsets.only(left: 2),
                color: AppColors.primary,
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fade(begin: 0.15, end: 1, duration: 500.ms),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 280.ms),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            '${PortfolioData.title}  ·  ${PortfolioData.subtitle}  ·  ${PortfolioData.role}',
            textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                ),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 340.ms),
        const SizedBox(height: 36),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment:
              context.isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            MagneticButton(
              label: 'Download Resume',
              icon: Icons.download_rounded,
              onTap: () => openUrl('https://hossamezzat.github.io/portfolio/resume.pdf'),
            ),
            MagneticButton(
              label: 'View Projects',
              filled: false,
              icon: Icons.work_outline_rounded,
              onTap: () => widget.onNavigate(SectionIds.projects),
            ),
            MagneticButton(
              label: 'Hire Me',
              filled: false,
              icon: Icons.handshake_outlined,
              onTap: () => widget.onNavigate(SectionIds.contact),
            ),
            MagneticButton(
              label: 'Contact',
              filled: false,
              icon: Icons.mail_outline_rounded,
              onTap: () => openUrl(SocialLinks.mailto),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 420.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: context.isDesktop
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            _SocialIcon(
              icon: Icons.code_rounded,
              tooltip: 'GitHub',
              onTap: () => openUrl(SocialLinks.github),
            ),
            _SocialIcon(
              icon: Icons.business_center_rounded,
              tooltip: 'LinkedIn',
              onTap: () => openUrl(SocialLinks.linkedin),
            ),
            _SocialIcon(
              icon: Icons.shop_rounded,
              tooltip: 'Google Play',
              onTap: () => openUrl(SocialLinks.playStore),
            ),
            _SocialIcon(
              icon: Icons.language_rounded,
              tooltip: 'Portfolio',
              onTap: () => openUrl(SocialLinks.portfolio),
            ),
            _SocialIcon(
              icon: Icons.chat_rounded,
              tooltip: 'WhatsApp',
              onTap: () => openUrl(SocialLinks.whatsapp),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 500.ms),
      ],
    );
  }

  Widget _buildPortrait(BuildContext context) {
    final portraitSize = context.responsive(
      mobile: 280.0,
      tablet: 340.0,
      desktop: 400.0,
    );

    return AnimatedBuilder(
      animation: Listenable.merge([_float, _halo]),
      builder: (context, _) {
        final floatY = math.sin(_float.value * math.pi) * 12;
        final parallaxX = _mouse.dx * 12;
        final parallaxY = _mouse.dy * 8;

        return SizedBox(
          height: portraitSize + 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animated gradient halo
              Transform.rotate(
                angle: _halo.value * math.pi * 2,
                child: Container(
                  width: portraitSize + 60,
                  height: portraitSize + 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.35),
                        AppColors.secondary.withValues(alpha: 0.2),
                        AppColors.accent.withValues(alpha: 0.35),
                        AppColors.highlight.withValues(alpha: 0.2),
                        AppColors.primary.withValues(alpha: 0.35),
                      ],
                    ),
                  ),
                ),
              ),
              // Soft glow
              Container(
                width: portraitSize + 20,
                height: portraitSize + 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 60,
                      spreadRadius: 10,
                    ),
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      blurRadius: 40,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
              // Animated rings
              ...List.generate(2, (i) {
                final progress = (_halo.value + i * 0.5) % 1.0;
                return Container(
                  width: portraitSize + 40 + progress * 40,
                  height: portraitSize + 40 + progress * 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary
                          .withValues(alpha: (1 - progress) * 0.25),
                      width: 1.5,
                    ),
                  ),
                );
              }),
              // Floating tech icons
              ..._techOrbits(portraitSize, _halo.value),
              // Portrait with glass frame
              Transform.translate(
                offset: Offset(parallaxX, floatY + parallaxY),
                child: Container(
                  width: portraitSize,
                  height: portraitSize * 1.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/hossam_portrait.jpg',
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, -0.15),
                        ),
                        // Glass shine
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: 80,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.25),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    )
        .animate()
        .fadeIn(duration: 900.ms, delay: 200.ms)
        .scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1));
  }

  List<Widget> _techOrbits(double size, double t) {
    final icons = [
      (Icons.flutter_dash, AppColors.primary),
      (Icons.cloud_outlined, AppColors.secondary),
      (Icons.code_rounded, AppColors.accent),
      (Icons.phone_android_rounded, AppColors.highlight),
    ];

    return List.generate(icons.length, (i) {
      final angle = t * math.pi * 2 + (i * math.pi * 2 / icons.length);
      final radius = size * 0.58;
      final x = math.cos(angle) * radius;
      final y = math.sin(angle) * radius * 0.75;

      return Transform.translate(
        offset: Offset(x, y),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white),
                boxShadow: AppColors.cardShadow,
              ),
              child: Icon(icons[i].$1, color: icons[i].$2, size: 22),
            ),
          ),
        ),
      );
    });
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final button = Padding(
      padding: const EdgeInsets.only(right: 10),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _hovered ? AppColors.primary : AppColors.border,
              ),
              boxShadow: _hovered
                  ? AppColors.glowShadow(AppColors.primary)
                  : AppColors.cardShadow,
            ),
            child: Center(
              child: Icon(
                widget.icon,
                size: 20,
                color: _hovered ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
    if (widget.tooltip == null) return button;
    return Tooltip(message: widget.tooltip!, child: button);
  }
}
