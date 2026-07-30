import 'package:flutter_test/flutter_test.dart';
import 'package:session/main.dart';

void main() {
  testWidgets('Portfolio app boots', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('Hossam Ezzat'), findsWidgets);
    await tester.pump(const Duration(seconds: 3));
  });
}
