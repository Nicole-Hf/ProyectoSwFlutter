// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/variables.dart';

class ConductorService {
  static Future<http.Response> createConductor(String fecha_nacimiento, String ci, 
  String telefono, String categoria_lic, String foto) async {
    Map data = {
      "ci": ci,
      "fecha_nacimiento": fecha_nacimiento,
      "telefono": telefono,
      "categoria_lic": categoria_lic,
      "foto": foto,
      "users_id": idUser
    };

    var body = json.encode(data);
    //String token = await getToken();
    var url = Uri.parse(createConductorUrl);
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json"
        //'Authorization': 'Bearer $token'
      },   
      body: body
    );

    debugPrint(response.body);
    return response;
  }

  static Future<http.Response> microbusRegister(String placa, String modelo, 
  String nroasientos, String nroInterno, String fechaasignacion,
  String fechabaja, String foto) async {
    Map data = {
      "placa": placa,
      "nroInterno": nroInterno,
      "fecha_asignacion": fechaasignacion,
      "modelo": modelo,
      "nro_asientos": nroasientos,
      "fecha_baja": fechabaja,
      "foto": foto,
      "linea_id": idLinea
    };

    var body = json.encode(data);
    var url = Uri.parse(createMicroUrl);
    http.Response response = await http.post(
        url,
        headers: headersC,
        body: body
    );
    debugPrint(response.body);
    return response;
  }
}