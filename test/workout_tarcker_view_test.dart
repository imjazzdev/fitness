import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/view/workout_tracker/workout_tracker_view.dart';
import 'package:fitness/view/workout_tracker/workour_detail_view.dart';
import 'package:fitness/common_widget/what_train_row.dart';

void main() {
  group('WorkoutTrackerView', () {
    // Mock data
    final mockWhatArr = [
      {
        "image": "assets/img/what_1.png",
        "title": "Fullbody Workout",
        "exercises": "11 Exercises",
        "time": "32mins"
      },
      {
        "image": "assets/img/what_2.png",
        "title": "Lowebody Workout",
        "exercises": "12 Exercises",
        "time": "40mins"
      },
      {
        "image": "assets/img/what_3.png",
        "title": "AB Workout",
        "exercises": "14 Exercises",
        "time": "20mins"
      }
    ];

    testWidgets('Displays list of workouts', (WidgetTester tester) async {
      // Render WorkoutTrackerView
      await tester.pumpWidget(const MaterialApp(home: WorkoutTrackerView()));

      // Verifikasi bahwa daftar latihan ditampilkan
      expect(find.byType(WhatTrainRow), findsNWidgets(mockWhatArr.length));

      // Verifikasi bahwa teks dalam daftar ditampilkan sesuai data mock
      for (var workout in mockWhatArr) {
        expect(find.text(workout["title"]!), findsOneWidget);
        expect(find.text(workout["exercises"]!), findsOneWidget);
        expect(find.text(workout["time"]!), findsOneWidget);
      }
    });

    testWidgets('Navigates to WorkoutDetailView when a workout is tapped',
        (WidgetTester tester) async {
      // Render WorkoutTrackerView
      await tester.pumpWidget(const MaterialApp(home: WorkoutTrackerView()));

      // Tap pada item pertama dalam daftar
      await tester.tap(find.text('Fullbody Workout'));
      await tester.pumpAndSettle();

      // Verifikasi bahwa navigasi ke WorkoutDetailView terjadi
      expect(find.byType(WorkoutDetailView), findsOneWidget);

      // Verifikasi data yang ditampilkan pada WorkoutDetailView
      expect(find.text('Fullbody Workout'), findsOneWidget);
      expect(find.text('11 Exercises'), findsOneWidget);
      expect(find.text('32mins'), findsOneWidget);
    });
  });
}
