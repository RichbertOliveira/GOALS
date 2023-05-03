import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goals/model/Expenses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import '../database/DbFile.dart';
import '../database/ExpensesDb.dart';
import '../main.dart';
import 'Despesas.dart';

class DespesasCreate extends StatefulWidget {
  @override
  State<DespesasCreate> createState() => _DespesasCreateState();
}

class _DespesasCreateState extends State<DespesasCreate> {
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final frequencyController = TextEditingController();
  final typeController = TextEditingController();

  void saveDespesa(String name, double value, String frequency, String type) async {
    final DbFile dbFile = DbFile();
    Database database = await dbFile.findDatabase();
    final ExpensesDb expensesFile = ExpensesDb();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var prevExpenses = expensesFile.findAllExpensesByType('', int.parse(prefs.getString('userId')!), database);



    var expense = Expenses(
      id: expensesFile.findLastId(database),
      name: name,
      value: value,
      frequency: frequency,
      type: type,
      userId: int.parse(prefs.getString('userId')!),
    );

    expensesFile.insertExpenses(expense, database);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inicio())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        title: const Text('Cadastro de Despesa'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: const TextStyle(fontSize: 15, color: Colors.white),
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nome da Despesa: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
                validator: (String? nomeGoal) {
                  if(nomeGoal == null || nomeGoal == '') {
                    return 'Digite o nome da Despesa';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: valueController,
                style: const TextStyle(fontSize: 15, color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Valor da Despesa: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
                validator: (String? nomeGoal) {
                  if(nomeGoal == null || nomeGoal == '') {
                    return 'Digite o valor da Despesa';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem<String>(child:Text("Selecionar Frequência")),
                  DropdownMenuItem<String>(child:Text("Diário"), value: 'DIARIO',),
                  DropdownMenuItem<String>(child:Text("Semanal"), value: 'SEMANAL',),
                  DropdownMenuItem<String>(child:Text("Mensal"), value: 'MENSAL',),
                  DropdownMenuItem<String>(child:Text("Anual"), value: 'ANUAL',),
                ],
                onChanged: (Object? value) {  },
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem<String>(child:Text("Selecionar Tipo de Despesa")),
                  DropdownMenuItem<String>(child:Text("Obrigatória Fixa"), value: 'FM',),
                  DropdownMenuItem<String>(child:Text("Obrigatória Variável"), value: 'VM',),
                  DropdownMenuItem<String>(child:Text("Não-Obrigatória Fixa"), value: 'FNM',),
                  DropdownMenuItem<String>(child:Text("Não-Obrigatória Variável"), value: 'VNM',),
                ],
                onChanged: (Object? value) {  },
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
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
                  onPressed: () {
                    saveDespesa(nameController.text, double.parse(valueController.text), frequencyController.text, typeController.text);
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