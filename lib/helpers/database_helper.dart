import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/photo.dart'; // Import model Photo
import '../models/profile.dart'; // Import model Profile

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'photo_gallery.db');

    return await openDatabase(
      path,
      version: 2, // Tingkatkan versi database
      onCreate: (db, version) async {
        await _createPhotoTable(db);
        await _createProfileTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _createProfileTable(db);
        }
      },
    );
  }

  Future<void> _createPhotoTable(Database db) async {
    await db.execute(
      'CREATE TABLE photos(id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT, date TEXT)',
    );
  }

  Future<void> _createProfileTable(Database db) async {
    await db.execute(
      'CREATE TABLE profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, height INTEGER, weight INTEGER, age INTEGER, profileImagePath TEXT)',
    );
  }

  // CRUD Operations for Photos
  Future<int> insertPhoto(Photo photo) async {
    final db = await database;
    return await db.insert('photos', photo.toMap());
  }

  Future<List<Photo>> getPhotos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('photos');

    return List.generate(maps.length, (i) {
      return Photo.fromMap(maps[i]);
    });
  }

  Future<int> deletePhoto(int id) async {
    final db = await database;
    return await db.delete('photos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePhoto(Photo photo) async {
    final db = await database;
    return await db.update('photos', photo.toMap(), where: 'id = ?', whereArgs: [photo.id]);
  }

  // CRUD Operations for Profiles
  Future<int> insertProfile(Profile profile) async {
    final db = await database;
    return await db.insert('profiles', profile.toMap());
  }

  Future<Profile?> getProfile(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'profiles',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Profile.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateProfile(Profile profile) async {
    final db = await database;
    return await db.update(
      'profiles',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
  }

  Future<int> updateProfilePicture(int id, String? profileImagePath) async {
    final db = await database;
    return await db.update(
      'profiles',
      {'profileImagePath': profileImagePath},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteProfile(int id) async {
    final db = await database;
    return await db.delete('profiles', where: 'id = ?', whereArgs: [id]);
  }

  
}
