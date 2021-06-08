import 'package:flutter/material.dart';
import 'package:gymapp/clases/Widgets/widget_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class anadir_emppresa extends StatelessWidget {
  CollectionReference users =
      FirebaseFirestore.instance.collection('gymnasios');
  anadirempresa(String nombre) {
    users.add({
      'full_name': nombre,
      'administrador': "sin administrador",
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    String texto;
    return Scaffold(
      appBar: AppBar(title: const Text('añadir gym')),
      drawer: WidgetDrawer(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'nombre de la empresa'),
                onChanged: (text) {
                  texto = text;
                },
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      primary: Colors.red),
                  onPressed: () {
                    anadir_emppresa();
                  },
                  icon: Icon(Icons.circle),
                  label: Text('confimar'))
            ],
          ),
        ),
      ),
    );
  }
}
