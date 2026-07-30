import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_cursor.dart';
import '../about/about_section.dart';
import '../awards/awards_section.dart';
import '../contact/contact_section.dart';
import '../experience/experience_section.dart';
import '../footer/footer_section.dart';
import '../hero/hero_section.dart';
import '../projects/projects_section.dart';
import '../skills/skills_section.dart';
import '../stats/stats_section.dart';
import '../teaching/teaching_section.dart';
import 'widgets/floating_nav.dart';
import 'widgets/living_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  bool _scrolled = false;
  String _active = SectionIds.home;

  final _sectionKeys = <String, GlobalKey>{
    SectionIds.home: GlobalKey(),
    SectionIds.about: GlobalKey(),
    SectionIds.experience: GlobalKey(),
    SectionIds.projects: GlobalKey(),
    SectionIds.teaching: GlobalKey(),
    SectionIds.awards: GlobalKey(),
    SectionIds.skills: GlobalKey(),
    SectionIds.contact: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 40;
    if (scrolled != _scrolled) {
      setState(() => _scrolled = scrolled);
    }
    _updateActiveSection();
  }

  void _updateActiveSection() {
    String? current;
    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final offset = box.localToGlobal(Offset.zero).dy;
      if (offset < 220) current = entry.key;
    }
    if (current != null && current != _active) {
      setState(() => _active = current!);
    }
  }

  Future<void> _navigateTo(String id) async {
    final key = _sectionKeys[id];
    final ctx = key?.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCursorOverlay(
      child: Scaffold(
        body: LivingBackground(
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  // Spacer for floating nav
                  const SliverToBoxAdapter(child: SizedBox(height: 0)),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.home],
                      child: HeroSection(onNavigate: _navigateTo),
                    ),
                  ),
                  const SliverToBoxAdapter(child: StatsSection()),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.about],
                      child: const AboutSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.experience],
                      child: const ExperienceSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.projects],
                      child: const ProjectsSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.teaching],
                      child: const TeachingSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.awards],
                      child: const AwardsSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.skills],
                      child: const SkillsSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: KeyedSubtree(
                      key: _sectionKeys[SectionIds.contact],
                      child: const ContactSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FooterSection(onNavigate: _navigateTo),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: FloatingNav(
                    scrolled: _scrolled,
                    activeSection: _active,
                    onNavigate: _navigateTo,
                    onHire: () => _navigateTo(SectionIds.contact),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
