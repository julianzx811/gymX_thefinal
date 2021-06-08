import 'package:cloud_firestore/cloud_firestore.dart';

//pedimos datos aqui para no estar repitiendo codigo
class DetalleEntrenamientoModel {
  String uid;
  String nombre;
  String descripcion;

  DetalleEntrenamientoModel({this.uid, this.nombre, this.descripcion});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nombre': nombre,
        'descripcion': descripcion,
      };

  DetalleEntrenamientoModel.fromJson(Map<String, Object> json)
      : this(
          uid: json['uid'] as String,
          nombre: json['nombre'] as String,
          descripcion: json['descripcion'] as String,
        );
  DetalleEntrenamientoModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        nombre = snapshot['nombre'],
        descripcion = snapshot['descripcion'];
}
