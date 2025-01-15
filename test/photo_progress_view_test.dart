import 'package:fitness/view/photo_progress/photo_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitness/helpers/database_helper.dart';
import 'package:fitness/models/photo.dart';

// Mock untuk ImagePicker dan DatabaseHelper
class MockImagePicker extends Mock implements ImagePicker {}

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  group('PhotoProgressView Tests', () {
    testWidgets('Renders all elements correctly', (WidgetTester tester) async {
      final mockDatabaseHelper = MockDatabaseHelper();
      when(mockDatabaseHelper.getPhotos()).thenAnswer(
        (_) async => [
          Photo(path: 'path/to/photo1', date: '01 01'),
          Photo(path: 'path/to/photo2', date: '02 01')
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: PhotoProgressView(),
        ),
      );

      // Act: Memuat widget
      await tester.pump();

      // Assert: Memastikan elemen-elemen ada
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(2)); // Gambar ditampilkan
      expect(
          find.byType(FloatingActionButton), findsOneWidget); // Floating button
    });

    testWidgets('Menampilkan gambar dari database',
        (WidgetTester tester) async {
      final mockDatabaseHelper = MockDatabaseHelper();
      when(mockDatabaseHelper.getPhotos()).thenAnswer(
        (_) async => [
          Photo(path: 'path/to/photo1', date: '01 01'),
          Photo(path: 'path/to/photo2', date: '02 01')
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: PhotoProgressView(),
        ),
      );

      // Act: Memuat widget dan foto
      await tester.pump();

      // Assert: Memastikan gambar ditampilkan
      expect(find.byType(Image), findsNWidgets(2)); // Dua gambar
    });
  });
}
