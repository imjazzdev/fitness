import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/models/photo.dart';

void main() {
  group('Photo Model Test', () {
    test('toMap() should convert Photo object to Map correctly', () {
      // Arrange
      final photo = Photo(id: 1, path: 'images/sample.jpg', date: '2025-01-16');

      // Act
      final map = photo.toMap();

      // Assert
      expect(map, {
        'id': 1,
        'path': 'images/sample.jpg',
        'date': '2025-01-16',
      });
    });

    test('fromMap() should convert Map to Photo object correctly', () {
      // Arrange
      final map = {
        'id': 2,
        'path': 'images/example.jpg',
        'date': '2025-01-17',
      };

      // Act
      final photo = Photo.fromMap(map);

      // Assert
      expect(photo.id, 2);
      expect(photo.path, 'images/example.jpg');
      expect(photo.date, '2025-01-17');
    });

    test('fromMap() should handle null id correctly', () {
      // Arrange
      final map = {
        'id': null,
        'path': 'images/no_id.jpg',
        'date': '2025-01-18',
      };

      // Act
      final photo = Photo.fromMap(map);

      // Assert
      expect(photo.id, isNull);
      expect(photo.path, 'images/no_id.jpg');
      expect(photo.date, '2025-01-18');
    });
  });
}
