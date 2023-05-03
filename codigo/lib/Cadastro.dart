import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:goals/Login.dart' show Login;
import 'main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;


import 'database/DbFile.dart';
import 'database/UsersDb.dart';
import 'model/User.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final DbFile dbFile = DbFile();
  final UsersDb usersDb = UsersDb();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();

  void cadastrar(String? name, String? email, String? password, String? passwordCheck) async {
    if(name == null || name == '') {
      return;
    }
    if(email == null || email == '') {
      return;
    }
    if(password == null || password == '') {
      return;
    }

    final DbFile dbFile = DbFile();
    Database database = await dbFile.findDatabase();
    final UsersDb usersFile = UsersDb();

    var user = User(
      id: usersFile.findLastId(database),
      name: name,
      email: email,
      password: password,
    );

    usersDb.insertUser(user, database);

    Navigator.pop(context);
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
                      "Cadastro",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),//Cadastro
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Material(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Digite seu nome',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, digite seu nome.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),//Name
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
                ),//Email
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
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Material(
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordCheckController,
                      decoration: const InputDecoration(
                        labelText: 'Confirmar Senha',
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
                ), //Confirmar Senha
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(255, 127, 80, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Color.fromRGBO(255, 127, 80, 1),
                          ))),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 127, 80, 1),
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    cadastrar(nameController.text, emailController.text, passwordController.text, passwordCheckController.text);
                  },
                ), //BtnCadastro
                TextButton(
                  child: const Text(
                    "Já tem conta? Faça o login aqui!",
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
                      MaterialPageRoute(
                          builder: (context) => Login()),
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
