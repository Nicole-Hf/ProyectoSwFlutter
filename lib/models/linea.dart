import 'dart:convert';

List<Linea> lineaFromJson(String str) => List<Linea>.from(json.decode(str).map((x) => Linea.fromJson(x)));

String lineaToJson(List<Linea> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Linea {
  Linea({
    required this.id,
    required this.linea,
    required this.horaInicio,
    required this.horaFinal,
  });

  final int id;
  final String linea;
  final String horaInicio;
  final String horaFinal;
  
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