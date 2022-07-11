import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:rutas_microbuses/constant.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

Future<ApiResponse> createRecorrido(String tipo) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    var url = Uri.parse(createRecorridoUrl);
    final response = await http.post(
      url,        
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: {
        'tipo': tipo,
        'drive_id': idDriving,
      }
    );
    debugPrint('StatusCodeR: ${response.statusCode}');
    debugPrint('BodyR: ${response.body}');
    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        debugPrint('Recorrido body: ${response.body}');
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  } 
  return apiResponse;
}

  Future<http.Response> iniciarRecorrido(String? tipo) async {
    Map data = {
      "tipo": tipo,
    };

    var body = json.encode(data);
    String token = await getToken();
    var url = Uri.parse(createRecorridoUrl);
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: body
    );
    debugPrint('Body Recorrido: ${response.body}');
    return response;
  }

  Future<http.Response> saveLocation(double? latitud, double? longitud) async {
    Map data = {
      "latitud": latitud,
      "longitud": longitud,
      "recorrido_id": idRecorrido
    };

    var body = json.encode(data);
    String token = await getToken();
    var url = Uri.parse(updateLocationUrl);
    http.Response response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: body
    );
    debugPrint('Body Tracking: ${response.body}');
    return response;
  }

  Future<http.Response> editLoc(double? latitud, double? longitud) async {
    Map data = {
      "latitud": latitud,
      "longitud": longitud,
      "recorrido_id": idRecorrido
    };

    var body = json.encode(data);
    String token = await getToken();
    var url = Uri.parse(updateLocationUrl);
    http.Response response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: body
    );
    debugPrint('Body Tracking: ${response.body}');
    return response;
  }