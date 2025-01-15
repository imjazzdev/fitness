import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/helpers/database_helper.dart';
import 'package:fitness/models/profile.dart';
import 'package:fitness/view/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  group('ProfileView', () {
    late MockDatabaseHelper mockDatabaseHelper;

    setUp(() {
      mockDatabaseHelper = MockDatabaseHelper();
    });

    testWidgets('ProfileView displays username and profile information',
        (WidgetTester tester) async {
      // Setup mock data
      const username = 'JohnDoe';
      final profile = Profile(
        id: 1,
        username: username,
        height: 170,
        weight: 70,
        age: 25,
        profileImagePath: null,
      );

      // Mock database helper method to return the profile
      when(mockDatabaseHelper.getProfile(1)).thenAnswer((_) async => profile);

      // Build widget
      await tester.pumpWidget(MaterialApp(
        home: ProfileView(username: username),
      ));

      // Verifikasi apakah username dan data profil tampil dengan benar
      expect(find.text(username), findsOneWidget);
      expect(find.text('170 cm'), findsOneWidget);
      expect(find.text('70 kg'), findsOneWidget);
      expect(find.text('25 yo'), findsOneWidget);
    });

    testWidgets('Pick image and update profile picture',
        (WidgetTester tester) async {
      // Setup mock data
      const username = 'JohnDoe';
      final profile = Profile(
        id: 1,
        username: username,
        height: 170,
        weight: 70,
        age: 25,
        profileImagePath: null,
      );

      // Mock database helper method to return the profile
      when(mockDatabaseHelper.getProfile(1)).thenAnswer((_) async => profile);

      // Build widget
      await tester.pumpWidget(MaterialApp(
        home: ProfileView(username: username),
      ));

      // Mock image picker
      final mockImage = File('path/to/image.png');
      final picker = MockImagePicker();
      when(picker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => XFile('path/to/image.png'));

      // Tap image profile to change
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      // Verify if the image is updated
      expect(
          find.byType(Image), findsOneWidget); // Ensure the image is displayed

      // Verify database update method is called
      verify(mockDatabaseHelper.updateProfilePicture(1, 'path/to/image.png'))
          .called(1);
    });

    testWidgets('Edit profile and save updated values',
        (WidgetTester tester) async {
      // Setup mock data
      const username = 'JohnDoe';
      final profile = Profile(
        id: 1,
        username: username,
        height: 170,
        weight: 70,
        age: 25,
        profileImagePath: null,
      );

      // Mock database helper method to return the profile
      when(mockDatabaseHelper.getProfile(1)).thenAnswer((_) async => profile);

      // Build widget
      await tester.pumpWidget(MaterialApp(
        home: ProfileView(username: username),
      ));

      // Tap the "Edit" button to open the dialog
      await tester.tap(find.byType(RoundButton));
      await tester.pumpAndSettle();

      // Verify dialog and fill the form with new values
      await tester.enterText(find.byType(TextField).at(0), '180'); // Height
      await tester.enterText(find.byType(TextField).at(1), '80'); // Weight
      await tester.enterText(find.byType(TextField).at(2), '26'); // Age

      // Tap the "Save" button in the dialog
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify that the new values are displayed
      expect(find.text('180 cm'), findsOneWidget);
      expect(find.text('80 kg'), findsOneWidget);
      expect(find.text('26 yo'), findsOneWidget);

      // Verify if the updateProfile method is called with updated values
      final updatedProfile = Profile(
        id: 1,
        username: username,
        height: 180,
        weight: 80,
        age: 26,
        profileImagePath: null,
      );
      verify(mockDatabaseHelper.updateProfile(updatedProfile)).called(1);
    });
  });
}

class MockImagePicker extends Mock implements ImagePicker {}
