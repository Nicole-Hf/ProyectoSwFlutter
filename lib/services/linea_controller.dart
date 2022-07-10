import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/bus.dart';
import 'package:rutas_microbuses/models/linea.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

class LineaController {
  static Future<List<Linea>> getLineaSuggestion(String query) async {
    final url = Uri.parse(getLineasUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List lineas = json.decode(response.body);
      debugPrint(response.body);
      return lineas.map((json) => Linea.fromJson(json)).where((linea) {
        final nameLower = linea.nombre.toLowerCase();
        final queryLower = query.toLowerCase();    
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<http.Response> createBus(
    String placa, 
    String modelo, 
    String nroasientos,
    String nroInterno,
    String fechaasignacion,
    String fechabaja, 
    String foto) async {
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
    var url = Uri.parse('${baseUrl}createBus');
    http.Response response = await http.post(
      url,
      headers: headersC,
      body: body
    );
    debugPrint(response.body);
    return response;
  }

  static Future<http.Response> getBus() async {
    var url = Uri.parse('${baseUrl}getBus/$idUser');
    http.Response response = await http.get(url);
    debugPrint(response.body);
    return response;
  }
}

Future<ApiResponse> getBusToday() async {
    ApiResponse apiResponse = ApiResponse();
    try{
      String token = await getToken();
      var url = Uri.parse(getMicroUrl);
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['bus'].map((p) => Bus.fromJson(p)).toList();
          apiResponse.data as List<dynamic>;
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    }
    catch (e) {
      apiResponse.error = serverError;
    }
    
    return apiResponse;
  }