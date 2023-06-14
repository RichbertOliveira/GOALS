import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GoalsDb {
  insertGoals(Map<String, dynamic> goals, Database db) async {

    int returnInsert = await db.insert(
        "goals",
        goals
    );

    return returnInsert;
  }

  updateGoals(int id, Map<String, dynamic> goals, Database db) async {

    int returnSave = await db.update(
        "goals",
        goals,
        where: "id = ?",
        whereArgs: [id]
    );

    return returnSave;
  }

  deleteGoals(int id, Database db) async {

    int returnDelete = await db.delete(
      "goals",
      where: "id = ?",
      whereArgs: [id],
    );

    return returnDelete;
  }

  searchGoalsByUser(int userId, Database db) async {
    final List<Map<String, dynamic>> expenses = await db.query(
      'goals',
      where: "userId = ?",
      whereArgs: [userId],
    );

    return expenses;
  }
}