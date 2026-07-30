// Portfolio content extracted from Hossam Ezzat Khalifa CV.

class PortfolioData {
  PortfolioData._();

  static const name = 'Hossam Ezzat Khalifa';
  static const firstName = 'Hossam';
  static const shortName = 'Hossam Ezzat';
  static const title = 'Flutter Developer';
  static const subtitle = 'Full Stack Mobile Engineer';
  static const role = 'Flutter Instructor';
  static const email = 'hossamezzat199@gmail.com';
  static const phone = '01064224826';
  static const birthDate = '25/1/2001';
  static const location = 'Egypt';

  static const bio =
      'Software Engineer focused on Flutter and mobile application development, '
      'experienced in building scalable apps using Clean Architecture and RESTful APIs. '
      'Skilled in Firebase and state management, with backend experience using '
      'ASP.NET Core for building robust APIs and full-stack mobile solutions.';

  static const typingRoles = [
    'Flutter Developer',
    'Mobile Engineer',
    'Clean Architecture Expert',
    'Flutter Instructor',
    'Tech Mentor',
    'Google Solution Challenge Winner',
  ];

  static const education = Education(
    degree: 'Bachelor of Computer and Information Science',
    department: 'CS Department',
    university: 'Zagazig University, Egypt',
    graduation: '2023',
    grade: 'Very Good',
  );

  static const stats = [
    StatItem(label: 'Years Experience', value: 3, suffix: '+'),
    StatItem(label: 'Projects', value: 12, suffix: '+'),
    StatItem(label: 'Production Apps', value: 8, suffix: '+'),
    StatItem(label: 'Students Taught', value: 200, suffix: '+'),
    StatItem(label: 'Academies', value: 7, suffix: ''),
    StatItem(label: 'Awards', value: 5, suffix: ''),
  ];

  static const experiences = [
    Experience(
      company: 'Opus365',
      role: 'Flutter Developer',
      period: '2026 – Present',
      type: 'Full-time',
      highlights: [
        'Develop and maintain cross-platform mobile applications using Flutter and Dart.',
        'Implement Clean Architecture, SOLID principles, and reusable components.',
        'Integrate REST APIs, Firebase services, and third-party SDKs.',
        'Collaborate with designers, backend developers, and product teams.',
        'Optimize application performance across Android and iOS platforms.',
      ],
    ),
    Experience(
      company: 'ALAhram-Tech',
      role: 'Flutter Developer',
      period: '07/2026',
      type: 'Part-time',
      highlights: [
        'Part-time Flutter developer for Battaka Business App.',
        'Delivered production features for a powerful project management platform.',
      ],
    ),
    Experience(
      company: 'Multiple Academies',
      role: 'Flutter & Programming Instructor',
      period: 'Ongoing',
      type: 'Teaching',
      highlights: [
        'Delivered Flutter and programming courses to 200+ students.',
        'Mentored students in mobile development projects and competitions.',
        'Designed practical learning materials and real-world projects.',
        'Academies: EraaSoft, Instant, Kian, MEC, Bright Brain, Vision, DRKashkool.',
      ],
    ),
    Experience(
      company: 'SAF Investment Group',
      role: 'Flutter Developer',
      period: '04/2023 – 01/2024',
      type: 'Full-time',
      highlights: [
        'Developed and maintained business-focused mobile applications.',
        'Integrated Firebase Authentication, Cloud Firestore, and RESTful APIs.',
        'Implemented responsive UI designs and improved application performance.',
        'Participated in feature development, testing, deployment, and maintenance.',
        'Translated business requirements into technical solutions with stakeholders.',
      ],
    ),
  ];

  static const projects = [
    Project(
      title: 'OPUS-365',
      description:
          'Enterprise HR management platform for Opus365 — streamlining workforce operations across iOS and Android.',
      category: 'Enterprise',
      technologies: ['Flutter', 'Firebase', 'REST API', 'Clean Architecture'],
      platforms: ['iOS', 'Android'],
      featured: true,
    ),
    Project(
      title: 'Battaka Business',
      description:
          'Powerful project management platform enabling teams to plan, track, and deliver work with clarity.',
      category: 'Business',
      technologies: ['Flutter', 'Firebase', 'Riverpod', 'REST API'],
      platforms: ['iOS', 'Android'],
      featured: true,
    ),
    Project(
      title: 'Z Store',
      description:
          'Modern e-commerce mobile experience with seamless browsing, cart, and checkout flows.',
      category: 'E-Commerce',
      technologies: ['Flutter', 'Firebase', 'Provider'],
      platforms: ['Android', 'iOS'],
    ),
    Project(
      title: 'Fe Alsika',
      description:
          'Lifestyle and discovery app connecting users with curated local experiences.',
      category: 'Lifestyle',
      technologies: ['Flutter', 'Google Maps', 'Firebase'],
      platforms: ['Android', 'iOS'],
    ),
    Project(
      title: 'Bedu',
      description:
          'Educational mobile platform designed for engaging learning experiences.',
      category: 'Education',
      technologies: ['Flutter', 'Firebase', 'Bloc'],
      platforms: ['Android', 'iOS'],
    ),
    Project(
      title: 'Fsolutions',
      description:
          'Business solutions app delivering practical tools for modern organizations.',
      category: 'Business',
      technologies: ['Flutter', 'REST API', 'Hive'],
      platforms: ['Android', 'iOS'],
    ),
    Project(
      title: 'Alpha Learn',
      description:
          'Student-focused learning application with interactive content and progress tracking.',
      category: 'Education',
      technologies: ['Flutter', 'Firebase', 'GetX'],
      platforms: ['Android', 'iOS'],
      subtitle: 'Student Version',
    ),
    Project(
      title: 'Folowsy Feen',
      description:
          'Social discovery experience helping users find and follow what matters.',
      category: 'Social',
      technologies: ['Flutter', 'Firebase', 'Google Maps'],
      platforms: ['Android', 'iOS'],
    ),
  ];

  static const awards = [
    Award(
      title: 'Golden Medal — Climate Change Awareness App',
      event: 'Climathon EUI 2022',
      place: '1st Place',
      region: 'Africa & Middle East',
      year: '2022',
      tier: AwardTier.gold,
    ),
    Award(
      title: 'Google Solution Challenge',
      event: 'AOU 2023',
      place: '1st Place',
      region: 'Regional',
      year: '2023',
      tier: AwardTier.gold,
    ),
    Award(
      title: 'Dell Competition',
      event: 'Dell Competition 2023',
      place: '2nd Place',
      region: 'Africa, Middle East & Turkey',
      year: '2023',
      tier: AwardTier.silver,
    ),
    Award(
      title: 'DevFest Competition',
      event: 'DevFest 2022',
      place: '2nd Place',
      region: 'Regional',
      year: '2022',
      tier: AwardTier.silver,
    ),
    Award(
      title: 'Huawei Academy Ambassador',
      event: 'Huawei Academy',
      place: 'Ambassador',
      region: 'Egypt',
      year: '2022',
      tier: AwardTier.honor,
    ),
  ];

  static const academies = [
    'EraaSoft Academy',
    'Instant Academy',
    'Kian Academy',
    'MEC Academy',
    'Bright Brain Academy',
    'Vision Academy',
    'DRKashkool Academy',
  ];

  static const skillCategories = [
    SkillCategory(
      name: 'Mobile',
      skills: [
        Skill(name: 'Flutter', level: 0.98),
        Skill(name: 'Dart', level: 0.96),
        Skill(name: 'Android', level: 0.88),
        Skill(name: 'iOS', level: 0.85),
      ],
    ),
    SkillCategory(
      name: 'State & Architecture',
      skills: [
        Skill(name: 'Riverpod', level: 0.92),
        Skill(name: 'Bloc', level: 0.90),
        Skill(name: 'Provider', level: 0.94),
        Skill(name: 'GetX', level: 0.88),
        Skill(name: 'Clean Architecture', level: 0.95),
      ],
    ),
    SkillCategory(
      name: 'Backend & Data',
      skills: [
        Skill(name: 'Firebase', level: 0.93),
        Skill(name: 'ASP.NET Core', level: 0.82),
        Skill(name: 'Supabase', level: 0.78),
        Skill(name: 'REST API', level: 0.94),
        Skill(name: 'Hive', level: 0.88),
        Skill(name: 'SQLite', level: 0.85),
      ],
    ),
    SkillCategory(
      name: 'DevOps & Tools',
      skills: [
        Skill(name: 'Git & GitHub', level: 0.95),
        Skill(name: 'CI/CD', level: 0.80),
        Skill(name: 'FCM', level: 0.90),
        Skill(name: 'Google Maps', level: 0.88),
        Skill(name: 'Notifications', level: 0.90),
      ],
    ),
  ];

  static const techStack = [
    'Flutter',
    'Dart',
    'Firebase',
    'Riverpod',
    'Bloc',
    'Provider',
    'GetX',
    'Hive',
    'SQLite',
    'REST API',
    'ASP.NET Core',
    'Supabase',
    'Git',
    'GitHub',
    'Google Maps',
    'FCM',
    'CI/CD',
    'Android',
    'iOS',
  ];

  static const aboutHighlights = [
    AboutHighlight(
      title: 'Clean Architecture',
      description:
          'Every production app is built with SOLID principles, testable layers, and scalable structure.',
      icon: 'architecture',
    ),
    AboutHighlight(
      title: 'Teaching DNA',
      description:
          '200+ students across 7 academies — mentoring the next generation of Flutter engineers.',
      icon: 'teaching',
    ),
    AboutHighlight(
      title: 'Award-Winning',
      description:
          'Google Solution Challenge winner, Climathon gold, and multiple regional competition medals.',
      icon: 'award',
    ),
    AboutHighlight(
      title: 'Full-Stack Mobile',
      description:
          'From Flutter UI to ASP.NET Core APIs and Firebase — end-to-end mobile solutions.',
      icon: 'fullstack',
    ),
  ];

  static const journey = [
    JourneyStep(
      year: '2021',
      title: 'The Beginning',
      description: 'Started the journey into software engineering and mobile development.',
    ),
    JourneyStep(
      year: '2022',
      title: 'First Gold',
      description:
          'Won Climathon EUI gold medal and became Huawei Academy Ambassador.',
    ),
    JourneyStep(
      year: '2023',
      title: 'Rising Star',
      description:
          'Graduated with Very Good grade. Google Solution Challenge 1st place. Joined SAF Investment Group.',
    ),
    JourneyStep(
      year: '2024',
      title: 'Mentor Era',
      description:
          'Expanded teaching across multiple academies, shaping 200+ Flutter developers.',
    ),
    JourneyStep(
      year: '2026',
      title: 'World Class',
      description:
          'Flutter Developer at Opus365. Building enterprise-grade HR and business platforms.',
    ),
  ];

  static var resumeUrl="https://drive.google.com/file/d/1bEypsRaTuHPJk2BZskjvNm_Dtok3QMB4/view?usp=sharing";
}

class Education {
  final String degree;
  final String department;
  final String university;
  final String graduation;
  final String grade;

  const Education({
    required this.degree,
    required this.department,
    required this.university,
    required this.graduation,
    required this.grade,
  });
}

class StatItem {
  final String label;
  final int value;
  final String suffix;

  const StatItem({
    required this.label,
    required this.value,
    required this.suffix,
  });
}

class Experience {
  final String company;
  final String role;
  final String period;
  final String type;
  final List<String> highlights;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.type,
    required this.highlights,
  });
}

class Project {
  final String title;
  final String description;
  final String category;
  final List<String> technologies;
  final List<String> platforms;
  final String? subtitle;
  final bool featured;

  const Project({
    required this.title,
    required this.description,
    required this.category,
    required this.technologies,
    required this.platforms,
    this.subtitle,
    this.featured = false,
  });
}

enum AwardTier { gold, silver, honor }

class Award {
  final String title;
  final String event;
  final String place;
  final String region;
  final String year;
  final AwardTier tier;

  const Award({
    required this.title,
    required this.event,
    required this.place,
    required this.region,
    required this.year,
    required this.tier,
  });
}

class Skill {
  final String name;
  final double level;

  const Skill({required this.name, required this.level});
}

class SkillCategory {
  final String name;
  final List<Skill> skills;

  const SkillCategory({required this.name, required this.skills});
}

class AboutHighlight {
  final String title;
  final String description;
  final String icon;

  const AboutHighlight({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class JourneyStep {
  final String year;
  final String title;
  final String description;

  const JourneyStep({
    required this.year,
    required this.title,
    required this.description,
  });
}
