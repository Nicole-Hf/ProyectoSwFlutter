import 'dart:convert';

Linea productFromJson(String str) => Linea.fromJson(json.decode(str));
String lineaToJson(Linea data) => json.encode(data.toJson());

class Linea {
  Linea({
    required this.id,
    required this.linea,
    required this.horaInicio,
    required this.horaFinal,
  });

  final int id;
  final String linea;
  final DateTime horaInicio;
  final DateTime horaFinal;
  
  factory Linea.fromJson(Map<String, dynamic> json) => Linea(
    id: json["id"],
    linea: json["linea"], 
    horaInicio: json["horaInicio"], 
    horaFinal: json["horaFinal"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "linea": linea,
    "horaInicio": horaInicio,
    "horaFinal": horaFinal,
  };
}