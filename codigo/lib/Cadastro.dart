import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:goals/Login.dart' show Login;
import 'main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import 'package:firebase_auth/firebase_auth.dart';

import 'database/DatabaseHelper.dart';
import 'database/UserDAO.dart';
import 'model/User.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _password = "";
  String _conformPassword = "";
  String _mensageError = "";

  void _cadastro() async{
    if(_formKey.currentState!.validate()){
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            _mensageError = "A senha é muito fraca";
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _mensageError = "Usuário já existente";
          });
        }
      } catch (e) {
        setState(() {
          _mensageError = "Ocorreu um erro inesperado";
        });
      }


      User? user = await UserDAO.getUserByEmail(_email);
      if(user == null && _password == _conformPassword){
        User newUser = User(id: await UserDAO.getLastId(), name: _name, email: _email, password: _password);
        UserDAO.insertUser(newUser);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
      else{
        setState(() {
          _mensageError = "Usuário já existente";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          const Center(
            child: Text(
              "Goals",
              style: TextStyle(
                fontSize: 42,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(48, 18, 48, 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Cadastro",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ), // name
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ), // Email
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ), // Password
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your confirm password';
                      }
                      if(_conformPassword != _password) {
                        return 'The confirm password is not match';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _conformPassword = value!;
                    },
                  ), //Confirm Password
                  Text(
                    _mensageError,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: OutlinedButton(
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.fromLTRB(80, 10, 80, 10))),
                        onPressed: _cadastro,
                        child: const Text(
                          "Cadastro",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(255, 127, 80, 1),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
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
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}



/* return Container(
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
    );*/