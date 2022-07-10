class Bus {
  Bus({
    this.id,
    this.foto,
    this.placa,
    this.modelo,
    this.interno,
    this.capacidad,
    this.conductor,
    this.linea,
  });

  int? id;
  String? foto;
  String? placa;
  String? modelo;
  int? interno;
  int? capacidad;
  String? conductor;
  String? linea;
  
  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json["id"],
      foto: json["foto"],
      placa: json["placa"], 
      modelo: json["modelo"], 
      interno: json["nroInterno"],
      capacidad: json["nro_asientos"],
      conductor: json["conductor"],
      linea: json["linea"],
    );
  }
}