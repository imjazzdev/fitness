import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/view/home/home_view.dart'; // Ganti dengan path yang sesuai
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('HomeView', () {
    // Uji apakah HomeView menampilkan username yang benar
    testWidgets('HomeView displays username correctly',
        (WidgetTester tester) async {
      // Username yang akan digunakan pada test
      const username = 'JohnDoe';

      // Membuild widget HomeView dengan username
      await tester.pumpWidget(MaterialApp(
        home: HomeView(username: username),
      ));

      // Memastikan username ditampilkan dengan benar
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text(username), findsOneWidget);
    });

    // Uji apakah carousel slider menampilkan gambar dengan benar
    testWidgets('Carousel slider shows images correctly',
        (WidgetTester tester) async {
      // Username dan workout untuk test
      const username = 'JohnDoe';

      await tester.pumpWidget(MaterialApp(
        home: HomeView(username: username),
      ));

      // Verifikasi apakah CarouselSlider ada di tampilan
      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(3)); // Pastikan ada 3 gambar
    });

    // Uji apakah indikator slider berfungsi dengan baik
    testWidgets('Carousel indicator works correctly',
        (WidgetTester tester) async {
      const username = 'JohnDoe';

      await tester.pumpWidget(MaterialApp(
        home: HomeView(username: username),
      ));

      // Menunggu beberapa frame untuk memastikan animasi indikator
      await tester.pumpAndSettle();

      // Memastikan ada indikator
      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);

      // Verifikasi apakah indikator berfungsi dengan benar
      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    // Uji apakah gambar untuk quotes ditampilkan dengan benar
    testWidgets('Quote images and texts are displayed correctly',
        (WidgetTester tester) async {
      const username = 'JohnDoe';

      await tester.pumpWidget(MaterialApp(
        home: HomeView(username: username),
      ));

      // Verifikasi apakah gambar quotes muncul di tampilan
      expect(
          find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is AssetImage,
          ),
          findsNWidgets(2)); // Pastikan ada 2 gambar quotes

      // Verifikasi apakah teks quotes juga ada
      expect(
          find.text(
              '“Three days on, one day off. Three days on, one day off. Repeat.”'),
          findsOneWidget);
      expect(find.text('- Chris Bumstead (CBum)'), findsOneWidget);
      expect(find.text('"The real workout starts when you want to stop"'),
          findsOneWidget);
      expect(find.text('- Ronnie Coleman'), findsOneWidget);
    });
  });
}
