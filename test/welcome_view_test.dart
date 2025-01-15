import 'package:fitness/view/login/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/view/main_tab/main_tab_view.dart'; // Ganti dengan import yang sesuai

void main() {
  testWidgets(
      'WelcomeView displays username and navigates to MainTabView on button press',
      (WidgetTester tester) async {
    // Definisikan nama pengguna untuk tes
    const username = 'JohnDoe';

    // Build widget
    await tester.pumpWidget(MaterialApp(
      home: WelcomeView(username: username),
    ));

    // Verifikasi apakah widget WelcomeView menampilkan nama pengguna dengan benar
    expect(find.text('Welcome, $username'), findsOneWidget);

    // Verifikasi apakah gambar ditampilkan
    expect(find.byType(Image), findsOneWidget);

    // Verifikasi apakah ada teks pengantar yang sesuai
    expect(
        find.text(
            "You are all set now, let’s reach your\ngoals together with us"),
        findsOneWidget);

    // Verifikasi apakah tombol "Go To Home" ada
    expect(find.text('Go To Home'), findsOneWidget);

    // Simulasi penekanan tombol
    await tester.tap(find.text('Go To Home'));
    await tester.pumpAndSettle();

    // Verifikasi apakah aplikasi menavigasi ke MainTabView
    expect(find.byType(MainTabView), findsOneWidget);

    // Verifikasi apakah username dikirim ke MainTabView dengan benar
    expect(find.text('Welcome, $username'), findsOneWidget);
  });
}
