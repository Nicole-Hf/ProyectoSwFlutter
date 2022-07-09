import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rutas_microbuses/constant.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

class RecorridoController {
  
  static Future<http.Response> createRecorrido(String? tipo) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String fecha = formatter.format(now);
    final DateFormat formathour = DateFormat('hh:mm');
    final String horaSalida = formathour.format(now);
    var tiempo = 45; //arreglar esta parte del tiempo, el tiempo estimado de llegada debe ser dado por el admin?
    var addTime = now.add(Duration(minutes: tiempo)); 
    final DateFormat formathourL = DateFormat('hh:mm');
    final String horaLlegada = formathourL.format(addTime);
    
    Map data = {
      "fecha": fecha,
      "horaSalida": horaSalida,
      "horaLlegada": horaLlegada,
      "tiempo": tiempo,
      "tipo": tipo,
    };

    var body = json.encode(data);
    String token = await getToken();
    var url = Uri.parse(createRecorridoUrl);
    http.Response response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: body
    );
    debugPrint('Body Recorrido: ${response.body}');
    return response;
  }

  static Future<http.Response> saveLocation(double? latitud, double? longitud) async {
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

  static Future<http.Response> editLoc(double? latitud, double? longitud) async {
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
}