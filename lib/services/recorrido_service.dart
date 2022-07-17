import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:rutas_microbuses/constant.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

  Future<http.Response> createRecorrido(String? tipo) async {
    Map data = {
      "tipo": tipo,
    };

    var body = json.encode(data);
    var url = Uri.parse('$createRecorridoUrl/$idConductor');
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body
    );
    debugPrint('Id conductor nuevo: $idConductor');
    debugPrint('Body Recorrido: ${response.body}');
    return response;
  }

  Future<http.Response> editLoc(double? latitud, double? longitud) async {
    Map data = {
      "latitud": latitud,
      "longitud": longitud,
    };

    var body = json.encode(data);
    String token = await getToken();
    var url = Uri.parse('$updateLocationUrl/$idRecorrido');
    http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: body
    );
    debugPrint('Body Tracking: ${response.body}');
    return response;
  }

  Future<http.Response> finishRecorrido() async {
    var url = Uri.parse('$finishRecorridoUrl/$idRecorrido');
    http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    debugPrint('Body Tracking: ${response.body}');
    return response;
  }

  Future<http.Response> saveRetiro(String? motivo) async {
    Map data = {
      "motivo": latitud,
      "recorrido_id": idRecorrido,
    };

    var body = json.encode(data);
    String token = await getToken();
    var url = Uri.parse(saveRetiroUrl);
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: body
    );
    debugPrint('Body Tracking: ${response.body}');
    return response;
  }