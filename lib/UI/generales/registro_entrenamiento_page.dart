import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/clases/Models/entrenamientosModel.dart';
import 'package:gymapp/UI/generales/detalles_entrenamiento_page.dart';
import 'package:gymapp/UI/generales/entrenamientos_page.dart';

class RegistroEntrenamientoPage extends StatefulWidget {
  final bool detalle;
  final String uid;

  const RegistroEntrenamientoPage({Key key, this.detalle, this.uid})
      : super(key: key);
  @override
  _RegistroEntrenamientoPageState createState() =>
      _RegistroEntrenamientoPageState();
}

class _RegistroEntrenamientoPageState extends State<RegistroEntrenamientoPage> {
  EntrenamientoModel _entrenamientoModel = EntrenamientoModel();
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir Entrenamiento'),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: new BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    _nombreEntrenamiento(),
                    SizedBox(height: 20),
                    _descripcionEntrenamiento(),
                    SizedBox(height: 20),
                    _buttonAdd(),
                    SizedBox(height: 20),
                  ],
                ),
              )),
        ));
  }

  Widget _nombreEntrenamiento() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Nombre',
        labelText: 'Nombre',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (value) {
        print(value);
        _entrenamientoModel.nombre = value;
      },
    );
  }

  Widget _descripcionEntrenamiento() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Descripción',
        labelText: 'Descripción',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (value) {
        print(value);
        _entrenamientoModel.detalle = value;
      },
    );
  }

  Widget _buttonAdd() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              // textColor: Colors.white,
            ),
            icon: Icon(
              Icons.save_rounded,
              color: Colors.white,
            ),
            label: Text('Guardar'),
            onPressed: () {
              _submit(context);
            },
          ),
        ),
      ],
    );
  }

  void _submit(BuildContext context) {
    try {
      if (widget.detalle == false) {
        databaseReference.collection('Entrenamientos').add({
          'nombre': _entrenamientoModel.nombre,
          'detalle': _entrenamientoModel.detalle,
        }).then((value) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EntrenamientosPage();
          }));
        });
      } else {
        databaseReference.collection('detalleEntrenamientos').add({
          'nombre': _entrenamientoModel.nombre,
          'descripcion': _entrenamientoModel.detalle,
          'uid': widget.uid,
        }).then((value) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetallesEntrenamientoPage(
              uid: widget.uid,
            );
          }));
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
