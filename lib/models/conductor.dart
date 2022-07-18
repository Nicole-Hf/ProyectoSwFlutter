class Conductor {
  int? id;
  String? name;
  String? email;
  String? ci;
  String? birthday;
  String? telefono;
  String? licencia;
  String? foto;

  Conductor({
    this.id,
    this.name,
    this.email,
    this.ci,
    this.birthday,
    this.telefono,
    this.licencia,
    this.foto
  });

  factory Conductor.fromJson(Map<String, dynamic> json) {
    return Conductor(
      id: json['conductor']['id'],
      name: json['conductor']['nombre'],
      email: json['conductor']['email'],
      ci: json['conductor']['ci'],
      birthday: json['conductor']['fecha_nacimiento'],
      telefono: json['conductor']['telefono'],
      licencia: json['conductor']['categoria_lic'],
      foto: json['conductor']['foto'],
    );
  }
}