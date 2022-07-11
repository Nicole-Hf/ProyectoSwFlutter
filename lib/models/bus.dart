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
    this.driving
  });

  int? id;
  String? foto;
  String? placa;
  String? modelo;
  int? interno;
  int? capacidad;
  String? conductor;
  String? linea;
  int? driving;
  
  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json["id"],
      foto: json["foto"],
      placa: json["placa"], 
      modelo: json["modelo"], 
      interno: json["interno"],
      capacidad: json["capacidad"],
      conductor: json["conductor"],
      linea: json["linea"],
      driving: json["driving"]
    );
  }
}