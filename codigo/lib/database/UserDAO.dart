import 'package:sqflite/sqflite.dart';

import '../model/User.dart';
import 'DatabaseHelper.dart';

class UserDAO extends DatabaseHelper {
  static const String _tableName = 'users';

  static Future<int> insertUser(User user) async {
    final Database db = await DatabaseHelper.createDatabase();

    return db.insert(
      _tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<int> getLastId() async{

    final Database db = await DatabaseHelper.createDatabase();
    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
      SELECT * FROM users ORDER BY id DESC LIMIT 1;
      '''
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first).id+1;
    }
    return 1;
  }

  static Future<List<User>> getUsers() async {
    final Database db = await DatabaseHelper.createDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  static Future<User?> getUserByEmail(String email) async {
    final Database db = await DatabaseHelper.createDatabase();

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }

    return null;
  }


  static Future<int> updateUser(User user) async {
    final Database db = await DatabaseHelper.createDatabase();

    return db.update(
      _tableName,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<int> deleteUser(int id) async {
    final Database db = await DatabaseHelper.createDatabase();

    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
