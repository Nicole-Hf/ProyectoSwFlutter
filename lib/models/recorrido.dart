class Recorrido {
  int? id;
  String? fecha;
  String? horaSalida;
  String? horaLlegada;
  String? tipo;

  Recorrido({
    this.id,
    this.fecha,
    this.horaSalida,
    this.horaLlegada,
    this.tipo
  });

  factory Recorrido.fromJson(Map<String, dynamic> json) => Recorrido(
    id: json["id"],
    fecha: json["fecha"],
    horaSalida: json["horaSalida"],
    horaLlegada: json["horaLlegada"],  
    tipo: json["tipo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha,
    "horaSalida": horaSalida,
    "horaLlegada": horaLlegada,
    "tipo": tipo,
  };
}