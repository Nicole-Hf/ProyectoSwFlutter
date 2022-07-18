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
      id: json["bus"]["id"],
      foto: json["bus"]["foto"],
      placa: json["bus"]["placa"], 
      modelo: json["bus"]["modelo"], 
      interno: json["bus"]["interno"],
      capacidad: json["bus"]["capacidad"],
      conductor: json["bus"]["conductor"],
      linea: json["bus"]["linea"],
    );
  }
}