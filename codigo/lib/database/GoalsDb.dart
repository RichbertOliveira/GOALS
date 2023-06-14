import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Goals.dart';

class GoalsDb {
  insertGoals(Goals goal) async {
    final db = FirebaseFirestore.instance;
    final expenseObject = <String, dynamic>{
      "name": goal.name,
      "value": goal.value,
    };

    db.collection("users/${goal.userId}/goals")
        .add(expenseObject)
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
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