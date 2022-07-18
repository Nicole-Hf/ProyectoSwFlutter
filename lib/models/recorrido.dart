class Recorrido {
  int? id;
  String? fecha;
  String? horaSalida;
  String? horaLlegada;
  double? latitud;
  double? longitud;
  String? tiempo;
  String? tipo;
  int? driveId;

  Recorrido({
    this.id,
    this.fecha,
    this.horaSalida,
    this.horaLlegada,
    this.latitud,
    this.longitud,
    this.tiempo,
    this.tipo,
    this.driveId
  });

  factory Recorrido.fromJson(Map<String, dynamic> json) {
    return Recorrido(
      id: json["id"],
      fecha: json["fecha"],
      horaSalida: json["horaSalida"],
      horaLlegada: json["horaLLegada"], 
      latitud: json['latitud'],
      longitud: json['longitud'], 
      tiempo: json['tiempo'],
      tipo: json["tipo"],
      driveId: json['drive_id']
    );
  }
}