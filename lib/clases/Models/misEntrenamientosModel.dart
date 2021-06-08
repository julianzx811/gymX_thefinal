import 'package:cloud_firestore/cloud_firestore.dart';

//pedimos datos aqui para no estar repitiendo codigo
class MisEntrenamientosModel {
  String uidEntrenamiento;
  String nombre;
  String detalle;

  MisEntrenamientosModel({this.uidEntrenamiento, this.nombre, this.detalle});

  Map<String, dynamic> toJson() => {
        'uidEntrenamiento': uidEntrenamiento,
        'nombre': nombre,
        'detalle': detalle,
      };

  MisEntrenamientosModel.fromJson(Map<String, Object> json)
      : this(
          uidEntrenamiento: json['uidEntrenamiento'] as String,
          nombre: json['nombre'] as String,
          detalle: json['detalle'] as String,
        );
  MisEntrenamientosModel.fromSnapshot(DocumentSnapshot snapshot)
      : uidEntrenamiento = snapshot['uidEntrenamiento'],
        nombre = snapshot['nombre'],
        detalle = snapshot['detalle'];
}
