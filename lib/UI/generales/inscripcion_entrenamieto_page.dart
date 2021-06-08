import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/clases/Models/entrenamientosModel.dart';

class InscripcionEntrenamientoPage extends StatefulWidget {
  @override
  _InscripcionEntrenamientoPageState createState() =>
      _InscripcionEntrenamientoPageState();
}

class _InscripcionEntrenamientoPageState
    extends State<InscripcionEntrenamientoPage> {
  final databaseReference = FirebaseFirestore.instance;
  int _conteo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Entrenamientos')),
        body: StreamBuilder(
            stream: getUsersTripsStreamSnapshots(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              _conteo = 0;
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildOrderCard(context, snapshot.data.docs[index]));
            }));
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) {
    final query = FirebaseFirestore.instance
        .collection('Entrenamientos')
        .withConverter<EntrenamientoModel>(
          fromFirestore: (snapshots, _) =>
              EntrenamientoModel.fromJson(snapshots.data()),
          toFirestore: (movie, _) => movie.toJson(),
        );

    return query.snapshots();
  }

  Widget buildOrderCard(BuildContext context, DocumentSnapshot document) {
    final entrenamiento = EntrenamientoModel.fromSnapshot(document);
    final uid = document.id;
    _conteo++;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      child: InkWell(
        onTap: () {
          _agregaEntrenamiento(uid, entrenamiento, document.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_conteo.toString() + '.- ' + entrenamiento.nombre),
                  Icon(Icons.arrow_right)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _agregaEntrenamiento(String uid, EntrenamientoModel entrenamientoModel,
      String uidEntrenamiento) async {
    var firebaseAuth = FirebaseAuth.instance.currentUser.uid;
    print(firebaseAuth);

    databaseReference.collection('misEntrenamientos').add({
      'nombre': entrenamientoModel.nombre,
      'detalle': entrenamientoModel.detalle,
      'uidEntrenamiento': uidEntrenamiento,
      'uidUsuario': firebaseAuth,
    }).then((value) {
      Navigator.pop(context);
    });
  }
}
