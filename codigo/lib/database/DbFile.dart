import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbFile {
  findDatabase() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "goals.db");

    var database = await openDatabase(
        localBD,
        version: 1,
        onCreate: (db, dbVersion) {
          String sql = "CREATE TABLE user ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "name VARCHAR, email VARCHAR, password VARCHAR"
              ");"
              "CREATE TABLE expenses ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "name VARCHAR, value DOUBLE, type VARCHAR, userId INTEGER)";
          db.execute(sql);
        }
    );

    return database;
  }

  saveDatabase() async {

  }


}
