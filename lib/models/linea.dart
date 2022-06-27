import 'dart:convert';

List<Linea> lineaFromJson(String str) => List<Linea>.from(json.decode(str).map((x) => Linea.fromJson(x)));

String lineaToJson(List<Linea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Linea {
  Linea({
    required this.id,
    required this.nombre,
    //required this.tipo,
  });

  final int id;
  final String nombre;
  //final String tipo;
  
  factory Linea.fromJson(Map<String, dynamic> json) => Linea(
    id: json["id"],
    nombre: json["nombre"], 
    //tipo: json["tipo"], 
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    //"tipo": tipo,
  };
}