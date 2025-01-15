import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/view/api_service.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Mock ApiService
class MockApiService extends Mock implements ApiService {}

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  group('SignUpView Tests', () {
    testWidgets('Initial UI is displayed correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpView()));
      expect(find.text('Create an Account'), findsOneWidget);
      expect(find.byType(RoundTextField), findsNWidgets(3));
      expect(find.byType(RoundButton), findsOneWidget);
    });

    testWidgets('Validation shows error for empty fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpView()));

      // Tap on the "Register" button
      await tester.tap(find.byType(RoundButton));
      await tester.pump();

      // Expect error messages
      expect(find.text('Semua field harus diisi.'), findsOneWidget);
    });

    testWidgets('Validation shows error for invalid email',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpView()));

      // Enter invalid email
      await tester.enterText(
          find.widgetWithText(RoundTextField, 'Email'), 'invalid_email');
      await tester.tap(find.byType(RoundButton));
      await tester.pump();

      // Expect error message
      expect(find.text('Format email tidak valid.'), findsOneWidget);
    });

    testWidgets('Successful registration calls API and navigates to login view',
        (WidgetTester tester) async {
      // Arrange: Mock successful API response
      when(mockApiService.register('username', 'email@test.com', 'password'))
          .thenAnswer((_) async => {'success': true});

      await tester.pumpWidget(MaterialApp(home: SignUpView()));

      // Enter valid input
      await tester.enterText(
          find.widgetWithText(RoundTextField, 'UserName'), 'username');
      await tester.enterText(
          find.widgetWithText(RoundTextField, 'Email'), 'email@test.com');
      await tester.enterText(
          find.widgetWithText(RoundTextField, 'Password'), 'password');

      // Act: Tap on the "Register" button
      await tester.tap(find.byType(RoundButton));
      await tester.pump();

      // Assert: Snackbar with success message
      expect(find.text('Registrasi berhasil! Silakan login.'), findsOneWidget);
    });

    testWidgets('Failed registration shows error message',
        (WidgetTester tester) async {
      // Arrange: Mock failed API response
      when(mockApiService.register('username', 'email@test.com', 'password'))
          .thenAnswer((_) async =>
              {'success': false, 'message': 'User already exists'});

      await tester.pumpWidget(MaterialApp(home: SignUpView()));

      // Enter valid input
      await tester.enterText(
          find.widgetWithText(RoundTextField, 'UserName'), 'username');
      await tester.enterText(
          find.widgetWithText(RoundTextField, 'Email'), 'email@test.com');
      await tester.enterText(
          find.widgetWithText(RoundTextField, 'Password'), 'password');

      // Act: Tap on the "Register" button
      await tester.tap(find.byType(RoundButton));
      await tester.pump();

      // Assert: Snackbar with error message
      expect(
          find.text('Registrasi gagal: User already exists'), findsOneWidget);
    });
  });
}
