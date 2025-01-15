import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/models/profile.dart';

void main() {
  group('Profile Model Test', () {
    test('toMap() should convert Profile object to Map correctly', () {
      // Arrange
      final profile = Profile(
        id: 1,
        username: 'JohnDoe',
        height: 180,
        weight: 75,
        age: 25,
        profileImagePath: 'images/profile.jpg',
      );

      // Act
      final map = profile.toMap();

      // Assert
      expect(map, {
        'id': 1,
        'username': 'JohnDoe',
        'height': 180,
        'weight': 75,
        'age': 25,
        'profileImagePath': 'images/profile.jpg',
      });
    });

    test('toMap() should handle null profileImagePath correctly', () {
      // Arrange
      final profile = Profile(
        id: 2,
        username: 'JaneDoe',
        height: 165,
        weight: 60,
        age: 22,
        profileImagePath: null,
      );

      // Act
      final map = profile.toMap();

      // Assert
      expect(map, {
        'id': 2,
        'username': 'JaneDoe',
        'height': 165,
        'weight': 60,
        'age': 22,
        'profileImagePath': null,
      });
    });

    test('fromMap() should convert Map to Profile object correctly', () {
      // Arrange
      final map = {
        'id': 3,
        'username': 'AlexSmith',
        'height': 170,
        'weight': 65,
        'age': 30,
        'profileImagePath': 'images/alex.jpg',
      };

      // Act
      final profile = Profile.fromMap(map);

      // Assert
      expect(profile.id, 3);
      expect(profile.username, 'AlexSmith');
      expect(profile.height, 170);
      expect(profile.weight, 65);
      expect(profile.age, 30);
      expect(profile.profileImagePath, 'images/alex.jpg');
    });

    test('fromMap() should handle null profileImagePath correctly', () {
      // Arrange
      final map = {
        'id': 4,
        'username': 'EmmaBrown',
        'height': 160,
        'weight': 55,
        'age': 28,
        'profileImagePath': null,
      };

      // Act
      final profile = Profile.fromMap(map);

      // Assert
      expect(profile.id, 4);
      expect(profile.username, 'EmmaBrown');
      expect(profile.height, 160);
      expect(profile.weight, 55);
      expect(profile.age, 28);
      expect(profile.profileImagePath, isNull);
    });
  });
}
