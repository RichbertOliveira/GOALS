import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Goals.dart';
import 'Login.dart';
import 'Sobre.dart';
import 'pages/Despesas.dart';
import 'database/DatabaseHelper.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));

}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _indiceAtual = 0;

  final List<Widget> _telas = [
    Despesas(despesas: "Despesas"),
    Goals("Goals"),
    Sobre("Sobre"),
  ];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[350],
        title: const Center (
          child: Center(child: Text("Goals")),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
          children: [
            _telas[_indiceAtual],
          ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        onTap: onTabTapped,
        items:
        const [
          BottomNavigationBarItem(icon: Icon(Icons.money_rounded), label: "Depesas",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Goals", backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.announcement), label: "Sobre", backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
