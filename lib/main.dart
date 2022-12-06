import 'package:chat_r3/proceso/autenticacion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'interface/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBvr-feCIYhshIdJ_vCku34ryuecOpX9G8",
          authDomain: "reto3chat-326c5.firebaseapp.com",
          projectId: "reto3chat-326c5",
          storageBucket: "reto3chat-326c5.appspot.com",
          messagingSenderId: "261830479834",
          appId: "1:261830479834:web:3938723e2081625bc43ae3",
          measurementId: "G-YGX1TNC7YF"));
  Get.put(Autenticacion());
  runApp(const MyApp());
}
