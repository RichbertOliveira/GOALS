import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/User.dart';

class UsersDb {
  insertUser(User user, Database db) async {

    int returnInsert = await db.insert(
        "user",
        user.toMap()
    );

    return returnInsert;
  }

  updateUser(int id, User user, Database db) async {

    int returnSave = await db.update(
        "user",
        user.toMap(),
        where: "id = ?",
        whereArgs: [id]
    );

    return returnSave;
  }

  deleteUser(int id, Database db) async {

    int returnDelete = await db.delete(
      "user",
      where: "id = ?",
      whereArgs: [id],
    );

    return returnDelete;
  }

  findLastId(Database database) async {
    var idList = await database.rawQuery("SELECT MAX(id) FROM users");

    return idList.elementAt(0);
  }
}