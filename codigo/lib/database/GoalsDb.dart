import 'dart:ffi';

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
      "stored": 0.0,
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

  deleteGoals(String id, String userId) async {
    final db = FirebaseFirestore.instance;
    await db.collection("users/$userId/goals")
      .doc(id)
      .delete();
  }

  searchGoalsByUser(String userId) async {
    final db = FirebaseFirestore.instance;
    final List<Map<String, dynamic>> goals = [];

    await db.collection("users/${userId}/goals")
        .get().then((event) {
      for (var doc in event.docs) {
        final data = doc.data() as Map<String, dynamic>;
        goals.add({
          "id": doc.id,
          "name": data['name'],
          "value": double.parse(data['value'].toString()),
          "stored": double.parse(data['stored'].toString()),
        });
      }
    });

    return goals;
  }
}