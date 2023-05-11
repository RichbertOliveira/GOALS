import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'my_database.db';
  static const int _databaseVersion = 1;

  static Future<Database> createDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name VARCHAR, 
              email VARCHAR, 
              password VARCHAR
              );
    ''');
    await db.execute('''
      CREATE TABLE expenses (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name VARCHAR, 
              value DOUBLE, 
              type VARCHAR, 
              frequency VARCHAR,
              userId INTEGER);
    ''');
  }
  static Future<void> deleteDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, _databaseName);
    await databaseFactory.deleteDatabase(path);
  }
}

