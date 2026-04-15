import 'package:flutter_test/flutter_test.dart';

import 'package:salat_streak/main.dart';

void main() {
  testWidgets('renders salat streak dashboard', (tester) async {
    await tester.pumpWidget(const SalatStreakApp());

    expect(find.text('Salat Streak'), findsOneWidget);
    expect(find.text('Prières du jour'), findsOneWidget);
    expect(find.text('Une app simple, locale et sans pub pour suivre ta régularité.'), findsOneWidget);
    expect(find.text('Aujourd’hui'), findsOneWidget);
  });
}
