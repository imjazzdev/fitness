import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/view/login/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/view/login/login_view.dart';
import 'package:fitness/view/api_service.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('LoginView Tests', () {
    testWidgets('Renders all elements correctly', (WidgetTester tester) async {
      // Arrange
      final mockApiService = MockApiService();
      await tester.pumpWidget(
        MaterialApp(
          home: LoginView(),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.byType(TextField),
          findsNWidgets(2)); // Two text fields (username, password)
      expect(find.byType(RoundButton),
          findsOneWidget); // One round button (Login button)
    });

    testWidgets('Shows loading indicator when logging in',
        (WidgetTester tester) async {
      // Arrange
      final mockApiService = MockApiService();
      when(mockApiService.login(
              any as String, any as String)) // Explicitly cast to String
          .thenAnswer((_) async => {'status': true, 'message': 'Success'});

      await tester.pumpWidget(
        MaterialApp(
          home: LoginView(),
        ),
      );

      // Enter username and password
      await tester.enterText(find.byType(TextField).at(0), 'testuser');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Act
      await tester.tap(find.byType(RoundButton)); // Tap the login button
      await tester.pump(); // Rebuild the widget after tap

      // Assert
      expect(find.byType(CircularProgressIndicator),
          findsOneWidget); // Loading indicator should show
    }, skip: true);

    testWidgets('Calls login API and navigates to WelcomeView on success',
        (WidgetTester tester) async {
      // Arrange
      final mockApiService = MockApiService();
      when(mockApiService.login(
              any as String, any as String)) // Explicitly cast to String
          .thenAnswer((_) async => {'status': true, 'message': 'Success'});

      await tester.pumpWidget(
        MaterialApp(
          home: LoginView(),
        ),
      );

      // Enter username and password
      await tester.enterText(find.byType(TextField).at(0), 'testuser');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Act
      await tester.tap(find.byType(RoundButton)); // Tap the login button
      await tester.pumpAndSettle(); // Wait for the navigation

      // Assert
      expect(find.byType(WelcomeView),
          findsOneWidget); // Should navigate to WelcomeView
    }, skip: true);

    testWidgets('Shows error message if login fails',
        (WidgetTester tester) async {
      // Arrange
      final mockApiService = MockApiService();
      when(mockApiService.login(
              any as String, any as String)) // Explicitly cast to String
          .thenAnswer(
              (_) async => {'status': false, 'message': 'Invalid credentials'});

      await tester.pumpWidget(
        MaterialApp(
          home: LoginView(),
        ),
      );

      // Enter username and password
      await tester.enterText(find.byType(TextField).at(0), 'wronguser');
      await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');

      // Act
      await tester.tap(find.byType(RoundButton)); // Tap the login button
      await tester.pumpAndSettle(); // Wait for the snackbar to appear

      // Assert
      expect(find.text('Login gagal: Invalid credentials'),
          findsOneWidget); // Error message should appear
    }, skip: true);
  });
}
