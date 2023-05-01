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
          String sql = "CREATE TABLE usuarios ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "nome VARCHAR, email VARCHAR, senha VARCHAR)";
          db.execute(sql);
        }
    );
  }

  saveDatabase() async {

  }


}
