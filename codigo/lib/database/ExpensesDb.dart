import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Expenses.dart';
import '../model/User.dart';

class ExpensesDb {
  insertExpenses(Expenses expense) async {
    final db = FirebaseFirestore.instance;
    final expenseObject = <String, dynamic>{
      "name": expense.name,
      "value": expense.value,
      "type": expense.type,
      "frequency": expense.frequency,
    };

    db.collection("users/${expense.userId}/expenses")
        .add(expenseObject)
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
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

  findAllExpensesByType(String type, String userId) async {
    final db = FirebaseFirestore.instance;

    final expenses = [];
    await db.collection("users/${userId}/expenses")
        .where("type", isEqualTo: type)
        .get().then((event) {
      for (var doc in event.docs) {
        final data = doc.data() as Map;
        // final data = Map<String, dynamic>.from(doc.data() as Map);
        expenses.add({
          "id": doc.id,
          "name": data['name'],
          "value": data['value'],
          "type": data['type'],
          "frequency": data['frequency'],
        });
      }
    });

    return expenses;
  }

  findLastId(Database database) async {
    var result = await database.rawQuery("SELECT id FROM expenses ORDER BY id DESC LIMIT 1");

    if (result.isNotEmpty) {
      var lastId = result.isNotEmpty ? result.first['id'] as int : 0;

      return lastId + 1;
    }

    return 1;
  }
}