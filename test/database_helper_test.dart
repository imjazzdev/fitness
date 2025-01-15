import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fitness/helpers/database_helper.dart';
import 'package:fitness/models/photo.dart';
import 'package:fitness/models/profile.dart';

// Membuat mock untuk sqflite.Database
class MockDatabase extends Mock implements Database {}

void main() {
  group('DatabaseHelper Tests', () {
    late DatabaseHelper dbHelper;
    late MockDatabase mockDb;

    setUp(() {
      mockDb = MockDatabase();
      dbHelper = DatabaseHelper();
    });

    test('Insert Photo should insert photo into the database', () async {
      // Mock response untuk insertPhoto
      when(mockDb.insert('photos', any as Map<String, Object?>))
          .thenAnswer((_) async => 1);

      final photo = Photo(id: 1, path: 'path/to/photo.jpg', date: '2023-01-01');
      final result = await dbHelper.insertPhoto(photo);

      // Memastikan fungsi insertPhoto dipanggil dan menghasilkan id
      expect(result, 1);
      verify(mockDb.insert('photos', photo.toMap())).called(1);
    });

    test('Get Photos should return list of photos from database', () async {
      // Mock response untuk getPhotos
      final mockPhotos = [
        Photo(id: 1, path: 'path/to/photo1.jpg', date: '2023-01-01'),
        Photo(id: 2, path: 'path/to/photo2.jpg', date: '2023-01-02')
      ];
      when(mockDb.query('photos')).thenAnswer((_) async => [
            {'id': 1, 'path': 'path/to/photo1.jpg', 'date': '2023-01-01'},
            {'id': 2, 'path': 'path/to/photo2.jpg', 'date': '2023-01-02'}
          ]);

      final result = await dbHelper.getPhotos();

      // Memastikan hasil yang diterima sesuai dengan data yang dimock
      expect(result, mockPhotos);
      verify(mockDb.query('photos')).called(1);
    });

    test('Delete Photo should delete photo from database', () async {
      // Mock response untuk deletePhoto
      when(mockDb.delete('photos',
              where: any, whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final result = await dbHelper.deletePhoto(1);

      // Memastikan delete dipanggil dengan benar
      expect(result, 1);
      verify(mockDb.delete('photos', where: 'id = ?', whereArgs: [1]))
          .called(1);
    });

    test('Update Photo should update photo in the database', () async {
      // Mock response untuk updatePhoto
      final photo =
          Photo(id: 1, path: 'path/to/photo_updated.jpg', date: '2023-01-03');
      when(mockDb.update('photos', any as Map<String, Object?>,
              where: any, whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final result = await dbHelper.updatePhoto(photo);

      // Memastikan update dipanggil dengan benar
      expect(result, 1);
      verify(mockDb.update('photos', photo.toMap(),
          where: 'id = ?', whereArgs: [1])).called(1);
    });

    test('Insert Profile should insert profile into the database', () async {
      // Mock response untuk insertProfile
      when(mockDb.insert('profiles', any as Map<String, Object?>))
          .thenAnswer((_) async => 1);

      final profile = Profile(
          id: 1, username: 'testuser', height: 180, weight: 70, age: 25);
      final result = await dbHelper.insertProfile(profile);

      // Memastikan insertProfile dipanggil dan menghasilkan id
      expect(result, 1);
      verify(mockDb.insert('profiles', profile.toMap())).called(1);
    });

    test('Get Profile should return profile from database', () async {
      // Mock response untuk getProfile
      final mockProfile = Profile(
          id: 1, username: 'testuser', height: 180, weight: 70, age: 25);
      when(mockDb.query('profiles',
              where: any, whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => [
                {
                  'id': 1,
                  'username': 'testuser',
                  'height': 180,
                  'weight': 70,
                  'age': 25
                }
              ]);

      final result = await dbHelper.getProfile(1);

      // Memastikan hasil yang diterima sesuai dengan data yang dimock
      expect(result, mockProfile);
      verify(mockDb.query('profiles', where: 'id = ?', whereArgs: [1]))
          .called(1);
    });

    test('Update Profile should update profile in the database', () async {
      // Mock response untuk updateProfile
      final profile = Profile(
          id: 1, username: 'testuser', height: 180, weight: 70, age: 26);
      when(mockDb.update('profiles', any as Map<String, Object?>,
              where: any, whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final result = await dbHelper.updateProfile(profile);

      // Memastikan updateProfile dipanggil dengan benar
      expect(result, 1);
      verify(mockDb.update('profiles', profile.toMap(),
          where: 'id = ?', whereArgs: [1])).called(1);
    });

    test('Delete Profile should delete profile from database', () async {
      // Mock response untuk deleteProfile
      when(mockDb.delete('profiles',
              where: any, whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      final result = await dbHelper.deleteProfile(1);

      // Memastikan delete dipanggil dengan benar
      expect(result, 1);
      verify(mockDb.delete('profiles', where: 'id = ?', whereArgs: [1]))
          .called(1);
    });
  });
}
