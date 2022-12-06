import 'package:chat_r3/proceso/autenticacion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Autenticacion ca = Get.find();

  Future<void> delay(int millis) async {
    await Future.delayed(Duration(milliseconds: millis));
  }

  void clear() async {
    await delay(1500);
    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login/Registro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.chat_sharp,
                size: 80,
              ),
            ),
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
                hintText: "Email", suffixIcon: Icon(Icons.email)),
          ),
          TextField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                  hintText: "Password", suffixIcon: Icon(Icons.key))),
          Divider(),
          ElevatedButton.icon(
              onPressed: () {
                ca.IniciarSesion(email: email.text, password: password.text)
                    .then((value) {})
                    .catchError((e) {
                  final text = '$e';
                  final snackBar = SnackBar(content: Text(text));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  clear();
                });
              },
              icon: Icon(Icons.login),
              label: Text("Iniciar Seccion")),
          Divider(),
          ElevatedButton.icon(
              onPressed: () {
                ca.CrearUsuario(email: email.text, password: password.text)
                    .then((value) {})
                    .catchError((e) {
                  final text = '$e';
                  final snackBar = SnackBar(content: Text(text));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  clear();
                });
              },
              icon: Icon(Icons.person_add),
              label: Text("Registrar Usuario"))
        ]),
      ),
    );
  }
}
