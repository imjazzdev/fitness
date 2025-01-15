import 'package:fitness/common_widget/exercises_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ExercisesRow widget test', (WidgetTester tester) async {
    // Data dummy untuk pengujian
    final Map<String, String> exerciseData = {
      "image": "assets/img/sample_image.png",
      "title": "Push Up",
      "value": "10 reps",
    };

    // Callback dummy
    bool buttonPressed = false;
    void onButtonPressed() {
      buttonPressed = true;
    }

    // Render widget ExercisesRow
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExercisesRow(
            eObj: exerciseData,
            onPressed: onButtonPressed,
          ),
        ),
      ),
    );

    // Verifikasi elemen-elemen widget
    expect(find.text("Push Up"), findsOneWidget);
    expect(find.text("10 reps"), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);

    // Verifikasi gambar ditampilkan dengan benar
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsWidgets);

    // Klik tombol untuk memicu onPressed
    await tester.tap(find.byType(IconButton));
    await tester.pump();

    // Verifikasi callback dipanggil
    expect(buttonPressed, true);
  });
}
