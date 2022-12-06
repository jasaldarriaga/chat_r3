import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Autenticacion extends GetxController {
  final FirebaseAuth fire = FirebaseAuth.instance;

  final Rx<dynamic> _email = "".obs;
  final _error = "".obs;

  String get emailr => _email.value;

  User? get usuarios => fire.currentUser;
  Stream<User?> get estadoLogin => fire.authStateChanges();

  Future<void> IniciarSesion(
      {required String email, required String password}) async {
    try {
      await fire.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _error.value = e.code;
      return Future.error(notification());
    }
  }

  Future<void> CrearUsuario(
      {required String email, required String password}) async {
    try {
      await fire.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _error.value = e.code;
      return Future.error(notification());
    }
  }

  Future<void> CerrarSesion() async {
    try {
      await fire.signOut();
    } on FirebaseAuthException catch (e) {
      _error.value = e.code;
      return Future.error(notification());
    }
  }

  String notification() {
    if (_error.value == 'weak-password') {
      return 'Contraseña Debil';
    } else if (_error.value == 'email-already-in-use') {
      return 'Email ya esta en Uso';
    } else if (_error.value == 'invalid-email') {
      return "Correo invalido";
    } else if (_error.value == 'missing-email') {
      return "Se requiere un email válido";
    } else if (_error.value == 'internal-error') {
      return "Error en los datos";
    } else if (_error.value == 'user-not-found') {
      return "Usuario/Contraseña incorrectas";
    } else {
      return _error.value;
    }
  }
}
