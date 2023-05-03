import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Expenses.dart';
import '../model/User.dart';

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

  findAllExpensesByType(String type, int userId, Database database) async {
    final List<Map<String, dynamic>> expenses = await database.query(
      'user',
      where: 'userId = ? AND type = ?',
      whereArgs: [userId, type],
    );

    return expenses;
  }
}