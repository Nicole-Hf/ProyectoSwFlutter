import 'package:flutter/material.dart';

const baseUrl = "http://10.0.2.2:8000/api/";
//const baseUrl = 'https://mainbusesgi.herokuapp.com/api/';
//const baseUrl = "http://127.0.0.1:8000/api/";

const loginUrl = '${baseUrl}login';
const registerUrl = '${baseUrl}register';
const logoutUrl = '${baseUrl}logout';
const userUrl = '${baseUrl}user';
const getLineasUrl = '${baseUrl}lineas';
const createConductorUrl = '${baseUrl}createDriver';
const createMicroUrl = '${baseUrl}bus';
const getMicroUrl = '${baseUrl}index';
const createRecorridoUrl = '${baseUrl}recorrido';
const updateLocationUrl = '${baseUrl}update';
const saveRetiroUrl = '${baseUrl}salir';

const Map<String, String> headers = {"Accept": "application/json"};
const Map<String, String> headersC = {"Content-Type": "application/json"};

const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Somethin went wrong, try again';

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3)
  ));
}