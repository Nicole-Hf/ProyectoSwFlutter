import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/services/globals.dart';

import '../utils/variables.dart';

class AuthServices {
  static Future<http.Response> register(String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };

    var body = json.encode(data);
    var url = Uri.parse('${baseUrl}auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body
    );
    // ignore: avoid_print
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseUrl}auth/login/conductor');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    
    // ignore: avoid_print
    print(response.body);
    return response;
  }

  static Future<http.Response> conductorRegister(String name, String fechanacimiento, String ci, String telefono,
      String categorialic) async {
    Map data = {
      "nombre": name,
      "fecha_nacimiento": fechanacimiento,
      "ci": ci,
      "telefono": telefono,
      "categoria_lic": categorialic,

      "users_id": idConductor,
    };

    var body = json.encode(data);
    var url = Uri.parse('${baseUrl}auth/UserConductor');
    http.Response response = await http.post(
        url,
        headers: headers,
        body: body
    );
    // ignore: avoid_print
    print(response.body);
    return response;
  }

  static Future<http.Response> microbusRegister(String placa, String modelo, int nro_asientos, String telefono,
      String categorialic) async {
    Map data = {
      "placa": name,
      "modelo": fechanacimiento,
      "nro_asientos": ci,
      "nro_linea": telefono,
      "nroInterno": categorialic,
      "fecha_asignacion": ci,
      "fecha_baja": telefono,
      "nroInterno": categorialic,
      "conductor_id": idConductor,
    };

    var body = json.encode(data);
    var url = Uri.parse('${baseUrl}auth/UserConductor');
    http.Response response = await http.post(
        url,
        headers: headers,
        body: body
    );
    // ignore: avoid_print
    print(response.body);
    return response;
  }
}