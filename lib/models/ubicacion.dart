class Ubicacion {
  int? id;
  String? latitud;
  String? longitud;
  
  Ubicacion({
    this.id,
    this.latitud,
    this.longitud,
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
    id: json["id"],
    latitud: json["latitud"],
    longitud: json["longitud"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "latitud": latitud,
    "longitud": longitud,
  };
}