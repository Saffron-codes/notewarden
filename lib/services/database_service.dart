import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String dbName = 'notewarden.db';
  static const int dbVersion = 1;
  static Database? _database;

  // Get the reference to the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = databasesPath+dbName;

    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _createDatabase,
    );
  }

  // Create the database tables
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Collection (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        createdAt TIMESTAMP NOT NULL,
        updatedAt TIMESTAMP NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Media (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        location TEXT NOT NULL,
        collectionId INTEGER,
        createdAt TIMESTAMP NOT NULL,
        FOREIGN KEY (collectionId) REFERENCES Collection (id)
      );
    ''');
  }
}
