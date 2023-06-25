import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/pages/teste_note.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController note = TextEditingController();
  TextEditingController description = TextEditingController();
  late String usuario = '';

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    usuario = auth.usuario!.email.toString();
    var range = Random();
    var id = range.nextInt(100000);

    final ref = fb.ref().child('notes/$id');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: note,
                decoration: const InputDecoration(
                  hintText: 'Note',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                ref.set({
                  "title": note.text,
                  "subtitle": description.text,
                  "user": usuario,
                }).asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              },
              child: const Icon(Icons.save_as_rounded),
            )
          ],
        ),
      ),
    );
  }
}
