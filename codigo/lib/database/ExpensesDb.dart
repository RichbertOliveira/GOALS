import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpensesDb {
  insertExpenses(Map<String, dynamic> expenses, Database db) async {

    int returnInsert = await db.insert(
        "expenses",
        expenses
    );

    return returnInsert;
  }

  updateExpenses(int id, Map<String, dynamic> expenses, Database db) async {

    int returnSave = await db.update(
        "expenses",
        expenses,
        where: "id = ?",
        whereArgs: [id]
    );

    return returnSave;
  }

  deleteExpenses(int id, Database db) async {

    int returnDelete = await db.delete(
      "expenses",
      where: "id = ?",
      whereArgs: [id],
    );

    return returnDelete;
  }
}