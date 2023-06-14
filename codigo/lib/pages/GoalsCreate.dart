import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:goals/model/Goals.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';

import '../database/DatabaseHelper.dart';
import '../database/GoalsDb.dart';

class GoalsCreate extends StatelessWidget {
  GoalsCreate({super.key});

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  void saveGoal(String name, double value) async {
    print('caiu 1');
    // Database database = await DatabaseHelper.createDatabase();
    final GoalsDb goalsFile = GoalsDb();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var goal = Goals(
      // id: await expensesFile.findLastId(database),
      name: name,
      value: value,
      userId: prefs.getString('userId')!,
    );

    await goalsFile.insertGoals(goal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cadastro de GOAL'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: TextFormField(
                style: const TextStyle(fontSize: 15, color: Colors.black),
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Nome do GOAL",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                validator: (String? nomeGoal) {
                  if(nomeGoal == null || nomeGoal == '') {
                    return 'Digite o nome do GOAL';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: valueController,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: "Valor do GOAL",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                validator: (String? nomeGoal) {
                  if(nomeGoal == null || nomeGoal == '') {
                    return 'Digite o valor do GOAL';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    saveGoal(nameController.text, double.parse(valueController.text));
                    Navigator.pop(context);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
