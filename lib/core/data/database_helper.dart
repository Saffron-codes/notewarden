import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;

// class DatabaseHelper {
//   static const String dbName = 'notewarden.db';
//   static const int dbVersion = 1;
//   static Database? _database;

//   // Get the reference to the database instance
//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     // If _database is null, initialize it
//     _database = await _initDatabase();
//     return _database!;
//   }

//   // Initialize the database
//   Future<Database?> _initDatabase() async {
//     if (await Permission.manageExternalStorage.request().isGranted ||
//         await Permission.storage.request().isGranted) {
//       final dbDir = await getDownloadsDirectory();
//       final String databasesPath = dbDir!.path;

//       //New Stuff
//       int index = databasesPath.indexOf("/0/");
//       String result = databasesPath.substring(0, index + 3);

//       final dir = Directory("${result}NoteWarden/");
//       if (!await dir.exists()) {
//         await dir.create(recursive: true);
//       }
//       final dbPath = dir.path + dbName;

//       return await openDatabase(
//         dbPath,
//         version: dbVersion,
//         onCreate: _createDatabase,
//       );
//     }
//     return null;
//   }

//   // Create the database tables
//   Future<void> _createDatabase(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS Collection (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL,
//         createdAt TIMESTAMP NOT NULL,
//         updatedAt TIMESTAMP NOT NULL
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS Media (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         location TEXT NOT NULL,
//         collectionId INTEGER,
//         createdAt TIMESTAMP NOT NULL,
//         FOREIGN KEY (collectionId) REFERENCES Collection (id)
//       );
//     ''');
//   }
// }

class DatabaseHelper {
  static const String dbName = 'notewarden.db';
  static const int dbVersion = 1;
  static Database? _database;

  DatabaseHelper() {
    initialize();
  }

  // Ensure sqflite_common_ffi is initialized
  static Future<void> initialize() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Get the reference to the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database?> _initDatabase() async {
    // Your database initialization code here
    final downloadsDir = await getDownloadsDirectory();
    final mainFolderPath = path.join(downloadsDir!.path, "NoteWarden");

    final mainFolderDir = Directory(mainFolderPath);

    if (!await mainFolderDir.exists()) {
      await mainFolderDir.create(recursive: true);
    }

    final dbPath = path.join(mainFolderPath, dbName);

    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: dbVersion,
        onCreate: _createDatabase,
      ),
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
