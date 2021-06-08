import 'package:cloud_firestore/cloud_firestore.dart';

//pedimos datos aqui para no estar repitiendo codigo
class EntrenamientoModel {
  String nombre;
  String detalle;

  EntrenamientoModel({this.nombre, this.detalle});

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'detalle': detalle,
      };

  EntrenamientoModel.fromJson(Map<String, Object> json)
      : this(
          nombre: json['nombre'] as String,
          detalle: json['detalle'] as String,
        );
  EntrenamientoModel.fromSnapshot(DocumentSnapshot snapshot)
      : nombre = snapshot['nombre'],
        detalle = snapshot['detalle'];
}
