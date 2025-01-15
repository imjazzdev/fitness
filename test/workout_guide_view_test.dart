import 'package:fitness/view/workout_tracker/workout_guide_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitness/view/home/finished_workout_view.dart';

void main() {
  group('WorkoutGuideView', () {
    // Mock data langkah workout
    final workoutSteps = [
      {
        "title": "Push Up",
        "imageB": "assets/img/push_up.png",
        "value": "10 reps",
        "desc": "A basic push-up exercise.",
      },
      {
        "title": "Squat",
        "imageB": "assets/img/squat.png",
        "value": "30",
        "desc": "A squat to strengthen legs.",
      },
    ];

    testWidgets('Displays workout step details (image, title, value, desc)',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WorkoutGuideView(workoutSteps: workoutSteps),
      ));

      // Verifikasi gambar, nama latihan, nilai, dan deskripsi untuk langkah pertama
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Push Up'), findsOneWidget);
      expect(find.text('10 reps'), findsOneWidget);
      expect(find.text('A basic push-up exercise.'), findsOneWidget);
    });

    testWidgets('Displays timer for timed step (value with seconds)',
        (WidgetTester tester) async {
      // Update data untuk langkah dengan timer
      final workoutStepsWithTimer = [
        {
          "title": "Plank",
          "imageB": "assets/img/plank.png",
          "value": "00:30",
          "desc": "Hold for 30 seconds.",
        },
      ];

      await tester.pumpWidget(MaterialApp(
        home: WorkoutGuideView(workoutSteps: workoutStepsWithTimer),
      ));

      // Verifikasi timer (untuk langkah dengan waktu)
      expect(find.text('00:30'), findsOneWidget);
    });

    testWidgets('Next step navigates to next workout step',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WorkoutGuideView(workoutSteps: workoutSteps),
      ));

      // Tekan tombol Next
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Verifikasi jika kita berada di langkah kedua
      expect(find.text('Squat'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
      expect(find.text('A squat to strengthen legs.'), findsOneWidget);
    });

    testWidgets('Back button works for navigating to previous step',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WorkoutGuideView(workoutSteps: workoutSteps),
      ));

      // Pindah ke langkah kedua
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Tekan tombol Back
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      // Verifikasi kita kembali ke langkah pertama
      expect(find.text('Push Up'), findsOneWidget);
      expect(find.text('10 reps'), findsOneWidget);
      expect(find.text('A basic push-up exercise.'), findsOneWidget);
    });

    testWidgets('Navigates to FinishedWorkoutView when all steps are complete',
        (WidgetTester tester) async {
      // Simulasikan seluruh langkah selesai
      final completedSteps = List.generate(10, (index) {
        return {
          "title": "Step $index",
          "imageB": "assets/img/step_$index.png",
          "value": "10 reps",
          "desc": "Description for step $index",
        };
      });

      await tester.pumpWidget(MaterialApp(
        home: WorkoutGuideView(workoutSteps: completedSteps),
      ));

      // Lakukan tap pada tombol Next sampai selesai
      for (int i = 0; i < completedSteps.length; i++) {
        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle();
      }

      // Pastikan halaman FinishedWorkoutView muncul setelah langkah selesai
      expect(find.byType(FinishedWorkoutView), findsOneWidget);
    });
  });
}
