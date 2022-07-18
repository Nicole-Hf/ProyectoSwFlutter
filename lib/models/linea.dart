import 'dart:convert';

List<Linea> lineaFromJson(String str) => List<Linea>.from(json.decode(str).map((x) => Linea.fromJson(x)));

String lineaToJson(List<Linea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Linea {
  Linea({
    required this.id,
    required this.nombre,
  });

  final int id;
  final String nombre;
  
  factory Linea.fromJson(Map<String, dynamic> json) => Linea(
    id: json["id"],
    nombre: json["nombre"],  
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
  };
}