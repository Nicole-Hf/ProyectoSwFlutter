class User {
  int? id;
  String? name;
  String? email;
  String? token;
  //int? conductorId;
  //String? conductorName;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
    //this.conductorId,
    //this.conductorName
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['token'],
      //conductorId: json['conductor']['id'],
      //conductorName: json['conductor']['nombre']
    );
  }
}