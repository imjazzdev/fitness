import 'package:fitness/view/workout_tracker/exercises_stpe_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExercisesStepDetails Widget Test', () {
    // Mock data
    final mockData = {
      "imageB": "assets/img/test_image.png",
      "title": "Push-ups",
      "value": "10 reps",
      "desc": "A basic exercise for upper body strength.",
    };

    testWidgets('Displays correct data based on eObj',
        (WidgetTester tester) async {
      // Render ExercisesStepDetails
      await tester.pumpWidget(
        MaterialApp(
          home: ExercisesStepDetails(eObj: mockData),
        ),
      );

      // Verifikasi bahwa gambar ditampilkan jika ada
      expect(find.byType(Image), findsOneWidget);

      // Verifikasi teks untuk title
      expect(find.text('Push-ups'), findsOneWidget);

      // Verifikasi teks untuk repetitions
      expect(find.text('10 reps'), findsOneWidget);

      // Verifikasi teks untuk deskripsi
      expect(find.text('A basic exercise for upper body strength.'),
          findsOneWidget);
    });

    testWidgets('Hides image if imageB is empty', (WidgetTester tester) async {
      // Data mock dengan image kosong
      final mockDataWithoutImage = {
        "imageB": "",
        "title": "Push-ups",
        "value": "10 reps",
        "desc": "A basic exercise for upper body strength.",
      };

      // Render widget
      await tester.pumpWidget(
        MaterialApp(
          home: ExercisesStepDetails(eObj: mockDataWithoutImage),
        ),
      );

      // Verifikasi bahwa gambar tidak ditampilkan
      expect(find.byType(Image), findsNothing);

      // Verifikasi teks lainnya tetap ditampilkan
      expect(find.text('Push-ups'), findsOneWidget);
      expect(find.text('10 reps'), findsOneWidget);
      expect(find.text('A basic exercise for upper body strength.'),
          findsOneWidget);
    });

    testWidgets('Navigates back when back button is pressed',
        (WidgetTester tester) async {
      // Render widget dengan navigator
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExercisesStepDetails(eObj: mockData),
          ),
        ),
      );

      // Verifikasi bahwa halaman saat ini adalah ExercisesStepDetails
      expect(find.text('Exercise Details'), findsOneWidget);

      // Tap pada tombol kembali
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verifikasi navigasi kembali berhasil (tidak ada Exercise Details di layar)
      expect(find.text('Exercise Details'), findsNothing);
    });
  });
}
