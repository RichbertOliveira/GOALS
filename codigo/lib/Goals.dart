import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';

import 'database/DatabaseHelper.dart';
import 'database/GoalsDb.dart';


class Goals extends StatefulWidget {
  String goals = 'goals';

  Goals({Key? key, required this.goals}): super(key: key);

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final GoalsDb goalsFile = GoalsDb();
  List<Map<String, dynamic>> goals = [];

  @override
  void initState() {
    super.initState();
    loadGoals();
  }

  Future<void> loadGoals() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Database database = await DatabaseHelper.createDatabase();

    var userId = prefs.getInt('userId');

    final List<Map<String, dynamic>> fetchedGoals = await goalsFile.searchGoalsByUser(userId!, database);

    setState(() {
      goals = fetchedGoals;
    });
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return ListView.builder(
          itemCount: goals.length+1,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if(index < goals.length) {
              final goal = goals[index];
              return GoalCard(
                  id: index,
                  title: goal['name'],
                  savedAmount: goal['stored'],
                  desiredAmount: goal['value']
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => _CadGoalsState())
                      );
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              );
            }
          },
        );
      }
    );
  }
}


class _CadGoalsState extends StatelessWidget {
  _CadGoalsState({super.key});

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
                style: const TextStyle(fontSize: 15, color: Colors.white),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Nome do GOAL: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
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
                style: const TextStyle(fontSize: 15, color: Colors.white),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: "Valor do GOAL: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
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

class _EditGoalsState extends StatelessWidget {
  _EditGoalsState({super.key});

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
                initialValue: "Viagem para Disney",
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
                initialValue: "2500.89",
                keyboardType: TextInputType.number,
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
                initialValue: "1500.00",
                keyboardType: TextInputType.number,
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
                  onPressed: () {
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

class GoalCard extends StatelessWidget {
  final int id;
  final String title;
  final double savedAmount;
  final double desiredAmount;

  const GoalCard(
      {super.key, required this.id,
        required this.title,
        required this.savedAmount,
        required this.desiredAmount});

  @override
  Widget build(BuildContext context) {
    double progressPercentage = (savedAmount / desiredAmount).clamp(0.0, 1.0);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _EditGoalsState())
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progressPercentage,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 8,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            savedAmount.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total: ${desiredAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}