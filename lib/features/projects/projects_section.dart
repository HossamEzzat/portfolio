import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/section_wrapper.dart';
import '../../data/portfolio_data.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _filter = 'All';
  String _query = '';

  List<String> get _categories => [
        'All',
        ...PortfolioData.projects.map((p) => p.category).toSet(),
      ];

  List<Project> get _filtered {
    return PortfolioData.projects.where((p) {
      final matchCat = _filter == 'All' || p.category == _filter;
      final matchQuery = _query.isEmpty ||
          p.title.toLowerCase().contains(_query.toLowerCase()) ||
          p.description.toLowerCase().contains(_query.toLowerCase()) ||
          p.technologies.any(
            (t) => t.toLowerCase().contains(_query.toLowerCase()),
          );
      return matchCat && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      id: SectionIds.projects,
      eyebrow: 'Selected Work',
      title: 'Products that ship',
      subtitle:
          'Enterprise platforms, learning apps, and business tools — crafted with Flutter and Clean Architecture.',
      child: Column(
        children: [
          // Search + filters
          LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < 700;
              return Flex(
                direction: narrow ? Axis.vertical : Axis.horizontal,
                children: [
                  Expanded(
                    flex: narrow ? 0 : 1,
                    child: TextField(
                      onChanged: (v) => setState(() => _query = v),
                      decoration: InputDecoration(
                        hintText: 'Search projects, tech…',
                        prefixIcon: const Icon(Icons.search_rounded),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: narrow ? 0 : 16, height: narrow ? 16 : 0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((cat) {
                        final active = _filter == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _filter = cat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: active
                                    ? AppColors.primaryGradient
                                    : null,
                                color: active ? null : Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: active
                                      ? Colors.transparent
                                      : AppColors.border,
                                ),
                              ),
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: active
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = constraints.maxWidth > 1000
                  ? 3
                  : constraints.maxWidth > 640
                      ? 2
                      : 1;
              final items = _filtered;
              if (items.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(48),
                  child: Text(
                    'No projects match your search.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: cols == 1 ? 1.15 : 0.85,
                ),
                itemBuilder: (context, i) => _ProjectCard(
                  project: items[i],
                  index: i,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, required this.index});
  final Project project;
  final int index;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  Offset _tilt = Offset.zero;

  static const _gradients = [
    [Color(0xFF2563EB), Color(0xFF38BDF8)],
    [Color(0xFF8B5CF6), Color(0xFF06B6D4)],
    [Color(0xFF06B6D4), Color(0xFF10B981)],
    [Color(0xFF2563EB), Color(0xFF8B5CF6)],
    [Color(0xFF38BDF8), Color(0xFF8B5CF6)],
    [Color(0xFF10B981), Color(0xFF2563EB)],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = _gradients[widget.index % _gradients.length];
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _tilt = Offset.zero;
      }),
      onHover: (e) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final local = box.globalToLocal(e.position);
        final dx = (local.dx / box.size.width - 0.5) * 2;
        final dy = (local.dy / box.size.height - 0.5) * 2;
        setState(() => _tilt = Offset(dx, dy));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_tilt.dx * 0.06)
          ..rotateX(-_tilt.dy * 0.06)
          ..translateByDouble(0.0, _hovered ? -8.0 : 0.0, 0, 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: colors[0].withValues(alpha: _hovered ? 0.28 : 0.12),
              blurRadius: _hovered ? 40 : 24,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Gradient "image" placeholder with pattern
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colors[0].withValues(alpha: _hovered ? 0.95 : 0.85),
                      colors[1].withValues(alpha: _hovered ? 0.9 : 0.75),
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: _MeshPainter(seed: widget.index),
                ),
              ),
              // Animated border glow
              if (_hovered)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              // Content
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.75),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              p.category,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (p.featured) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        p.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      if (p.subtitle != null)
                        Text(
                          p.subtitle!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        p.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.technologies.take(3).map((t) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        child: _hovered
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  children: [
                                    _ActionChip(
                                      icon: Icons.open_in_new_rounded,
                                      label: 'Details',
                                      onTap: () {},
                                    ),
                                    const SizedBox(width: 8),
                                    _ActionChip(
                                      icon: Icons.code_rounded,
                                      label: 'GitHub',
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              // Top platforms
              Positioned(
                top: 20,
                right: 20,
                child: Row(
                  children: p.platforms.map((plat) {
                    return Container(
                      margin: const EdgeInsets.only(left: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        plat,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: colors[0],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.text),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeshPainter extends CustomPainter {
  _MeshPainter({required this.seed});
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(seed + 7);
    final paint = Paint()..style = PaintingStyle.stroke;

    for (var i = 0; i < 18; i++) {
      paint
        ..color = Colors.white.withValues(alpha: 0.08 + rng.nextDouble() * 0.1)
        ..strokeWidth = 1;
      final y = rng.nextDouble() * size.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 20), paint);
    }

    for (var i = 0; i < 8; i++) {
      paint
        ..style = PaintingStyle.fill
        ..color = Colors.white.withValues(alpha: 0.06);
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height),
        20 + rng.nextDouble() * 60,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) => false;
}
