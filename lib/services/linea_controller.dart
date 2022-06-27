// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:rutas_microbuses/models/linea.dart';
import 'package:rutas_microbuses/utils/globals.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/utils/variables.dart';

class LineaController {
  static Future<List<Linea>> getLineaSuggestion(String query) async {
    final url = Uri.parse('${baseUrl}lineas');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List lineas = json.decode(response.body);
      print(response.body);
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
      headers: headers,
      body: body
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> getBus() async {
    var url = Uri.parse('${baseUrl}getBus/$idConductor');
    http.Response response = await http.get(url);
    print(response.body);
    return response;
  }

}