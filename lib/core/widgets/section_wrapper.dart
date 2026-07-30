import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

class SectionWrapper extends StatefulWidget {
  const SectionWrapper({
    super.key,
    required this.id,
    required this.child,
    this.eyebrow,
    this.title,
    this.subtitle,
    this.padding,
    this.centerHeader = true,
  });

  final String id;
  final Widget child;
  final String? eyebrow;
  final String? title;
  final String? subtitle;
  final EdgeInsetsGeometry? padding;
  final bool centerHeader;

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('section-${widget.id}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        key: Key(widget.id),
        width: double.infinity,
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: context.horizontalPadding,
              vertical: context.responsive(mobile: 64, tablet: 88, desktop: 120),
            ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
            child: Column(
              crossAxisAlignment: widget.centerHeader
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                if (widget.eyebrow != null) ...[
                  _Eyebrow(text: widget.eyebrow!)
                      .animate(target: _visible ? 1 : 0)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 16),
                ],
                if (widget.title != null) ...[
                  Text(
                    widget.title!,
                    textAlign:
                        widget.centerHeader ? TextAlign.center : TextAlign.start,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: context.responsive(
                            mobile: 32,
                            tablet: 40,
                            desktop: 48,
                          ),
                        ),
                  )
                      .animate(target: _visible ? 1 : 0)
                      .fadeIn(duration: 600.ms, delay: 80.ms)
                      .slideY(begin: 0.25, end: 0),
                  const SizedBox(height: 16),
                ],
                if (widget.subtitle != null) ...[
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Text(
                      widget.subtitle!,
                      textAlign: widget.centerHeader
                          ? TextAlign.center
                          : TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                      .animate(target: _visible ? 1 : 0)
                      .fadeIn(duration: 600.ms, delay: 140.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 48),
                ] else if (widget.title != null)
                  const SizedBox(height: 48),
                widget.child
                    .animate(target: _visible ? 1 : 0)
                    .fadeIn(duration: 700.ms, delay: 200.ms)
                    .slideY(begin: 0.08, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.accent.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
      ),
    );
  }
}

class FadeInView extends StatefulWidget {
  const FadeInView({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slide = 24,
  });

  final Widget child;
  final Duration delay;
  final double slide;

  @override
  State<FadeInView> createState() => _FadeInViewState();
}

class _FadeInViewState extends State<FadeInView> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: widget.child
          .animate(target: _visible ? 1 : 0)
          .fadeIn(duration: 650.ms, delay: widget.delay)
          .slideY(begin: widget.slide / 100, end: 0, curve: Curves.easeOutCubic),
    );
  }
}
