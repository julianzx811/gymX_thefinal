import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/UI/generales/entrenamientos_page.dart';
//

class DetallesEntrenamientoPage extends StatefulWidget {
  final String uid;
  final String detalle;
  final bool edicion;
  const DetallesEntrenamientoPage(
      {Key key, this.uid, this.edicion, this.detalle})
      : super(key: key);
  @override
  _DetallesEntrenamientoPageState createState() =>
      _DetallesEntrenamientoPageState();
}

class _DetallesEntrenamientoPageState extends State<DetallesEntrenamientoPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Entrenamiento')),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 4,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.detalle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        primary: Colors.red),
                    onPressed: () {
                      _eliminaEntrenamiento(widget.uid);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Eliminar entrenamiento'))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _eliminaEntrenamiento(String uid) {
    print(uid);
    FirebaseFirestore.instance
        .collection('Entrenamientos')
        .doc(uid)
        .get()
        .then((snapshot) {
      snapshot.reference.delete();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return EntrenamientosPage();
      }));
    });
  }
}
