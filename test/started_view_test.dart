import 'package:fitness/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitness/view/on_boarding/on_boarding_view.dart';

void main() {
  group('StartedView Tests', () {
    testWidgets('Displays Bugarraga title and subtitle',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StartedView(),
        ),
      );

      // Memastikan title "Bugarraga" ditampilkan
      expect(find.text('Bugarraga'), findsOneWidget);

      // Memastikan subtitle "Home Fitness" ditampilkan
      expect(find.text('Home Fitness'), findsOneWidget);
    });

    testWidgets('Displays Get Started button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StartedView(),
        ),
      );

      // Memastikan tombol "Get Started" ditampilkan
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('Navigates to OnBoardingView when Get Started button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StartedView(),
        ),
      );

      // Tekan tombol "Get Started"
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Memastikan halaman OnBoardingView muncul
      expect(find.byType(OnBoardingView), findsOneWidget);
    });
  });
}
