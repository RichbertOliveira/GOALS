import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import 'package:goals/main.dart';
import 'Cadastro.dart';
import 'database/DbFile.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final DbFile dbFile = DbFile();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void Login(String? email, String? password) async {
    if(email == null || email == '') {
      return;
    }
    if(password == null || password == '') {
      return;
    }

    Database database = await dbFile.findDatabase();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> users = await database.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if(users.length > 0) {
      var user = prefs.setString('userId', users[0]['id']);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inicio()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Column(
        children: [
          const Center(
            child: Text(
              "Goals",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                decoration: TextDecoration.none,
              ),
            ),
          ), //Header
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Material(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Digite seu email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, digite um email.';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Por favor, digite um email válido.';
                        }
                        return null;
                      },
                    ),
                  ),
                ), //Email
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Material(
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, digite sua senha.';
                        }
                        return null;
                      },
                    ),
                  ),
                ), //Senha
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(255, 127, 80, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                              color: Color.fromRGBO(255, 127, 80, 1),
                            ))),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 127, 80, 1),
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Login(emailController.text, passwordController.text);
                    },
                  ),
                ),//BtnLogin
                TextButton(
                  child: const Text(
                    "Não tem conta? Crie sua conta aqui!",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 127, 80, 1),
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cadastro()),
                    );
                  },
                ), //Cadastrar
              ],
            ),
          ), //Form
        ],
      ),
    );
  }
}
