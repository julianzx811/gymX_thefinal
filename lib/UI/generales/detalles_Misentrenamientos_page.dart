import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/usuario/mis_entrenamientos_page.dart';

class DetallesMisEntrenamientoPage extends StatefulWidget {
  final String uid;
  final String detalle;
  final bool edicion;
  const DetallesMisEntrenamientoPage(
      {Key key, this.uid, this.edicion, this.detalle})
      : super(key: key);
  @override
  _DetallesEntrenamientoPageState createState() =>
      _DetallesEntrenamientoPageState();
}

String texto;

class _DetallesEntrenamientoPageState
    extends State<DetallesMisEntrenamientoPage> {
  int _conteo = 0;
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
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'codigo de la clase'),
                      onChanged: (text) {
                        texto = text;
                      },
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
                      _eliminaDetalle(widget.uid);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('confirmar asistencia'))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _eliminaDetalle(String uid) {
    print(uid);
    FirebaseFirestore.instance
        .collection('misEntrenamientos')
        .doc(uid)
        .get()
        .then((snapshot) {
      snapshot.reference.delete();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MisEntrenamientosPage();
      }));
    });
  }
}
