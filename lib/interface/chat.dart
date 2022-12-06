import 'package:chat_r3/interface/mensajes.dart';
import 'package:chat_r3/proceso/autenticacion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

final mensaje = TextEditingController();
final fire = FirebaseFirestore.instance;

class _chatState extends State<chat> {
  Autenticacion ca = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  ca.CerrarSesion();
                },
                icon: Icon(Icons.logout)),
            VerticalDivider(),
            Text((ca.usuarios?.email).toString())
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: mensaje,
                    decoration: InputDecoration(hintText: "Mensaje..."),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (mensaje.text.isNotEmpty) {
                        fire.collection("Chat").doc().set({
                          "mensaje": mensaje.text,
                          "tiempo": DateTime.now(),
                          "email": (ca.usuarios?.email).toString()
                        });
                        mensaje.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.orange,
                    ))
              ],
            ),
            Container(
              child: const Expanded(child: mensajes()),
            )
          ],
        ),
      ),
    );
  }
}
