import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/clases/Models/entrenamientosModel.dart';
import 'package:gymapp/clases/Widgets/widget_drawer.dart';
import 'package:gymapp/UI/generales/registro_entrenamiento_page.dart';

import 'detalles_entrenamiento_page.dart';

class EntrenamientosPage extends StatefulWidget {
  @override
  _EntrenamientosPageState createState() => _EntrenamientosPageState();
}

class _EntrenamientosPageState extends State<EntrenamientosPage> {
  int _conteo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrenamientos')),
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
      floatingActionButton: _floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _floatingButton() {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return RegistroEntrenamientoPage(
              detalle: false,
            );
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
    // final uid = document.id;
    final detalle = entrenamiento.detalle;
    final uidEntrenamiento = document.id;
    _conteo++;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetallesEntrenamientoPage(
              uid: uidEntrenamiento,
              edicion: true,
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
}

class ProductDetails extends StatelessWidget {
  final EntrenamientoModel entrenamientoModel;

  const ProductDetails({Key key, this.entrenamientoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Detalles del producto",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              tooltip: "Eliminar",
              icon: Icon(
                Icons.delete_outline,
                size: 30.0,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 14.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
