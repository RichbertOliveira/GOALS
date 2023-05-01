import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UsersDb {
  insertUser(Map<String, dynamic> user, Database db) async {

    int returnInsert = await db.insert(
        "user",
        user
    );

    return returnInsert;
  }

  updateUser(int id, Map<String, dynamic> user, Database db) async {

    int returnSave = await db.update(
        "user",
        user,
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
}