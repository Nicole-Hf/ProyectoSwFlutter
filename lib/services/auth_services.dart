import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/services/globals.dart';

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
    var url = Uri.parse('${baseUrl}auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    
    // ignore: avoid_print
    print(response.body);
    return response;
  }  
}