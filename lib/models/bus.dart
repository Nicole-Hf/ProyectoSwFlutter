import 'dart:convert';

List<Bus> busFromJson(String str) => List<Bus>.from(json.decode(str).map((x) => Bus.fromJson(x)));

String busToJson(List<Bus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bus {
  Bus({
    required this.id,
    required this.placa,
    required this.modelo,
    required this.interno,
    required this.capacidad,
    required this.conductor,
    required this.linea,
  });

  final int id;
  final String placa;
  final String modelo;
  final String interno;
  final String capacidad;
  final String conductor;
  final String linea;
  
  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
    id: json["id"],
    placa: json["placa"], 
    modelo: json["modelo"], 
    interno: json["nroInterno"],
    capacidad: json["nro_asientos"],
    conductor: json["conductor"],
    linea: json["linea"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "placa": placa,
    "modelo": modelo,
    "interno": interno,
    "capacidad": capacidad,
    "conductor": conductor,
    "linea": linea,
  };
}