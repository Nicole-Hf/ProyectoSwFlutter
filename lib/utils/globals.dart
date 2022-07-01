import 'package:flutter/material.dart';


const String baseUrl = 'https://mainbusesgi.herokuapp.com/api/';
/*"http://127.0.0.1:8000/api/";*/ /*"http://10.0.2.2:8000/api/";*/

const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3)
  ));
}