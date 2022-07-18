// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/conductor.dart';
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

  static Future<http.Response> createMicrobus(String placa, String modelo, String nroasientos, 
    String nroInterno, String fechaasignacion, String fechabaja, String foto) async {
    Map data = {
      "placa": placa,
      "nroInterno": nroInterno,
      "fecha_asignacion": fechaasignacion,
      "modelo": modelo,
      "nro_asientos": nroasientos,
      "fecha_baja": fechabaja,
      "foto": foto,
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

Future<ApiResponse> loginDriver(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
      Uri.parse(loginDriverUrl),
      headers: headers,
      body: {'email': email, 'password': password}
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = Conductor.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }catch(e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getConductorDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.get(
      Uri.parse('$driverUrl/$idConductor'),
      headers: {
        'Accept': 'application/json',
      },     
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = Conductor.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;     
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }catch(e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}


