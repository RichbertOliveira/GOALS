import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:goals/model/Goals.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';

import '../database/DatabaseHelper.dart';
import '../database/GoalsDb.dart';

class GoalsEdit extends StatelessWidget {
  final String id;
  final String title;
  final double savedAmount;
  final double desiredAmount;

  final titleController = TextEditingController();
  final savedAmountController = TextEditingController();
  final desiredController = TextEditingController();
  final insertController = TextEditingController();

  GoalsEdit({
    super.key,
    required this.id,
    required this.title,
    required this.desiredAmount,
    required this.savedAmount,
  });

  void initState() {
    titleController.text = title;
    savedAmountController.text = savedAmount.toString();
    desiredController.text = desiredAmount.toString();
  }

  Future<void> apagarGoal() async {
    final GoalsDb goalsFile = GoalsDb();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final userId = prefs.getString('userId') ?? "";
    await goalsFile.deleteGoals(id, userId);
  }

  @override
  Widget build(BuildContext context) {
    initState();
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
                // initialValue: title,
                controller: titleController,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Nome do GOAL: ",
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
                // initialValue: desiredAmount.toString(),
                keyboardType: TextInputType.number,
                controller: desiredController,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Valor do GOAL: ",
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
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: TextFormField(
                initialValue: savedAmount.toString(),
                keyboardType: TextInputType.number,
                // controller: savedAmountController,
                readOnly: true,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Guardado: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: insertController,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: "Valor a retirar ou guardar: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Retirar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
            Container(height: 100,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await apagarGoal();
                    Navigator.pop(context);
                  },
                  child: const Text('Deletar Goal'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}