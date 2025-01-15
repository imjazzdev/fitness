import 'package:fitness/view/home/finished_workout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/common_widget/round_button.dart';

void main() {
  group('FinishedWorkoutView widget tests', () {
    testWidgets('Displays all static elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FinishedWorkoutView(),
        ),
      );

      // Verifikasi gambar ditampilkan
      expect(find.byType(Image), findsOneWidget);

      // Verifikasi teks utama
      expect(
        find.text("Congratulations, You Have Finished Your Workout"),
        findsOneWidget,
      );

      // Verifikasi teks kutipan
      expect(
        find.text(
          "Exercises is king and nutrition is queen. Combine the two and you will have a kingdom",
        ),
        findsOneWidget,
      );

      // Verifikasi nama penulis kutipan
      expect(find.text("-Jack Lalanne"), findsOneWidget);

      // Verifikasi tombol "Back To Home"
      expect(find.widgetWithText(RoundButton, "Back To Home"), findsOneWidget);
    });

    testWidgets('Back To Home button triggers Navigator.pop',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FinishedWorkoutView(),
        ),
      );

      // Simulasikan klik tombol
      await tester.tap(find.widgetWithText(RoundButton, "Back To Home"));
      await tester.pumpAndSettle();

      // Karena tombol memanggil `Navigator.pop`, kita perlu memastikan tidak ada error saat kembali
      // Anda juga bisa memeriksa apakah halaman saat ini berubah
      expect(find.byType(FinishedWorkoutView), findsNothing);
    });
  });
}
