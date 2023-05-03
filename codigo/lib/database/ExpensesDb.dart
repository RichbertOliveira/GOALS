import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Expenses.dart';
import '../model/User.dart';

class ExpensesDb {
  insertExpenses(Expenses expense, Database db) async {

    int returnInsert = await db.insert(
        "expenses",
        expense.toMap()
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

  findAllExpensesByType(String type, int userId, Database database) async {
    final List<Map<String, dynamic>> expenses = await database.query(
      'expenses',
    );

    return expenses;
  }

  findLastId(Database database) async {
    var idList = await database.rawQuery("SELECT MAX(id) FROM expenses");

    return idList.elementAt(0);
  }
}