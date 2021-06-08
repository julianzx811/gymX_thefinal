import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/clases/Models/misEntrenamientosModel.dart';
import 'package:gymapp/clases/Widgets/widget_drawer.dart';
import 'package:gymapp/clases/Models/entrenamientosModel.dart';
import 'package:gymapp/UI/generales/detalles_Misentrenamientos_page.dart';
import 'package:gymapp/UI/generales/inscripcion_entrenamieto_page.dart';

class MisEntrenamientosPage extends StatefulWidget {
  @override
  _MisEntrenamientosPageState createState() => _MisEntrenamientosPageState();
}

class _MisEntrenamientosPageState extends State<MisEntrenamientosPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Entrenamientos')),
      drawer: WidgetDrawer(),
      body: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            _conteo = 0;
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildOrderCard(context, snapshot.data.docs[index]));
          }),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _floatingActionButton() {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return InscripcionEntrenamientoPage();
          }));
        },
        child: Container(
            height: 50.0,
            width: 50.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 45,
            )),
        backgroundColor: Colors.green,
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    final query = FirebaseFirestore.instance
        .collection('misEntrenamientos')
        .where('uidUsuario', isEqualTo: useruid)
        .withConverter<EntrenamientoModel>(
          fromFirestore: (snapshots, _) =>
              EntrenamientoModel.fromJson(snapshots.data()),
          toFirestore: (movie, _) => movie.toJson(),
        );

    return query.snapshots();
  }

  Widget buildOrderCard(BuildContext context, DocumentSnapshot document) {
    final entrenamiento = MisEntrenamientosModel.fromSnapshot(document);
    final detalle = entrenamiento.detalle;
    final uidEntrenamiento = document.id;

    _conteo++;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetallesMisEntrenamientoPage(
              uid: uidEntrenamiento,
              edicion: false,
              detalle: detalle,
            );
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(_conteo.toString() + '.- ' + entrenamiento.nombre),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
