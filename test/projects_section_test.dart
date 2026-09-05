import 'package:flutter_test/flutter_test.dart';
import 'package:session/data/portfolio_data.dart';

void main() {
  test('BabyCare is the featured lead project with store links', () {
    final babyCare = PortfolioData.projects.firstWhere(
      (p) => p.title == 'BabyCare',
    );

    expect(babyCare.featured, isTrue);
    expect(babyCare.subtitle, 'by Rooka');
    expect(babyCare.category, 'Health');
    expect(
      babyCare.appStoreUrl,
      'https://apps.apple.com/app/babycare-by-rooka/id6806644760',
    );
    expect(
      babyCare.playStoreUrl,
      'https://play.google.com/store/apps/details?id=com.rooka.babycare',
    );
  });
}
