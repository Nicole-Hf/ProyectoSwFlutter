class User {
  int? id;
  String? name;
  String? email;
  String? token;
  String? linea;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
    this.linea,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      linea: json['user']['linea_id'],
      token: json['token'],
    );
  }
}