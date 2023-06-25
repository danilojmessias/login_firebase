// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'add_note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fb = FirebaseDatabase.instance;
  late String usuario = '';
  TextEditingController notes = TextEditingController();
  TextEditingController description = TextEditingController();

  var id;
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    usuario = auth.usuario!.email.toString();

    final ref = fb.ref().child('notes');

    final teste = fb.ref().equalTo(usuario);

    log(teste.toString());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AddNote(),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Notas do $usuario',
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          var val = snapshot.value as Map<dynamic, dynamic>;

          return ListTile(
            title: Text(val['title']),
            subtitle: Text(val['title']),
            trailing: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.child(snapshot.key!).remove();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("notes/$id");

    await ref1.update({
      "title": notes.text,
      "subtitle": description.text,
    });
    notes.clear();
    description.clear();
  }
}
