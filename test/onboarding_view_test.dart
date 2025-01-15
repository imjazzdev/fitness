// test/onboarding_view_test.dart
import 'package:fitness/view/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/view/login/signup_view.dart';

void main() {
  group('OnBoardingView Tests', () {
    testWidgets('Renders all elements correctly', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: OnBoardingView(),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(
          find.byType(PageView), findsOneWidget); // PageView should be present
      expect(find.byType(OnBoardingView),
          findsOneWidget); // OnBoardingView renders
      expect(find.byType(IconButton), findsOneWidget); // IconButton present
    });
  });
}
