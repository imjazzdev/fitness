import 'package:fitness/common_widget/exercises_set_section.dart';
import 'package:fitness/view/workout_tracker/workour_detail_view.dart';
import 'package:fitness/view/workout_tracker/workout_guide_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitness/common_widget/round_button.dart';

void main() {
  group('WorkoutDetailView', () {
    testWidgets('WorkoutDetailView displays the correct title and exercises',
        (WidgetTester tester) async {
      // Setup mock data
      final dObj = {
        "title": "Fullbody Workout",
      };

      // Buat widget untuk halaman workout detail
      await tester.pumpWidget(MaterialApp(
        home: WorkoutDetailView(dObj: dObj), // Ganti dengan nama yang benar
      ));

      // Verifikasi judul yang sesuai
      expect(find.text('Fullbody Workout'), findsOneWidget);

      // Verifikasi jika daftar latihan muncul sesuai dengan jenis workout
      expect(find.text('Exercises'), findsOneWidget);
      expect(find.byType(ExercisesSetSection),
          findsWidgets); // Memastikan ada widget ExercisesSetSection
    });

    testWidgets('Navigating to Workout Guide on "Start Workout" button press',
        (WidgetTester tester) async {
      // Setup mock data
      final dObj = {
        "title": "Fullbody Workout",
      };

      // Buat widget untuk halaman workout detail
      await tester.pumpWidget(MaterialApp(
        home: WorkoutDetailView(dObj: dObj),
      ));

      // Tap tombol Start Workout
      await tester.tap(find.byType(RoundButton));
      await tester.pumpAndSettle();

      // Verifikasi jika navigasi mengarah ke WorkoutGuideView
      expect(find.byType(WorkoutGuideView),
          findsOneWidget); // Pastikan kita berada di halaman WorkoutGuideView
    });

    testWidgets('Displays correct exercises based on workout type',
        (WidgetTester tester) async {
      // Mock data untuk Fullbody Workout
      final fullbodyExercises = [
        {
          "set": [
            {"exercise": "Push Up"},
            {"exercise": "Squat"}
          ]
        },
        {
          "set": [
            {"exercise": "Lunges"}
          ]
        }
      ];
      final dObj = {
        "title": "Fullbody Workout",
      };

      // Buat widget untuk halaman workout detail dengan latihan fullbody
      await tester.pumpWidget(MaterialApp(
        home: WorkoutDetailView(
          dObj: dObj,
        ),
      ));

      // Verifikasi daftar latihan sesuai dengan workout
      expect(find.text('Push Up'), findsOneWidget);
      expect(find.text('Squat'), findsOneWidget);
      expect(find.text('Lunges'), findsOneWidget);
    });
  });
}
