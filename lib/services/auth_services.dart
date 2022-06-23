// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/utils/globals.dart';
import 'package:rutas_microbuses/utils/variables.dart';

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
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseUrl}auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> conductorRegister(String name, String fechanacimiento, String ci, String telefono,
      String categorialic, String foto) async {
    Map data = {
      "nombre": name,
      "ci": ci,
      "fecha_nacimiento": fechanacimiento,
      "telefono": telefono,
      "categoria_lic": categorialic,
      "foto": foto,
      "users_id": idUser,
    };

    var body = json.encode(data);
    var url = Uri.parse('${baseUrl}auth/UserConductor');
    http.Response response = await http.post(
        url,
        headers: headers,
        body: body
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> microbusRegister(String placa, String modelo, String nroasientos,
      String nroInterno,String fechaasignacion,String fechabaja, String foto) async {
    Map data = {
      "placa": placa,
      "nroInterno": nroInterno,
      "fecha_asignacion": fechaasignacion,
      "modelo": modelo,
      "nro_asientos": nroasientos,
      "fecha_baja": fechabaja,
      "foto": foto,
      "conductor_id": idConductor,
      "linea_id": idLinea
    };

    var body = json.encode(data);
    var url = Uri.parse('${baseUrl}auth/MicrobusPerfil');
    http.Response response = await http.post(
        url,
        headers: headers,
        body: body
    );
    print(response.body);
    return response;
  }
}