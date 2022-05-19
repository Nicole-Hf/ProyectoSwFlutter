import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/controllers/linea_controller.dart';
import 'package:rutas_microbuses/models/linea.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);
  
  @override
  _BusPageState createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  String _interno = '';
  String _placa = '';
  String _modelo = '';
  String _servicios = '';
  String _capacidad = '';
  final _formKey = GlobalKey<FormState>();
  final _typeAheadController = TextEditingController();
  
  createBusPressed() async {
    http.Response response = await LineaController.createBus(_placa, _modelo, _servicios, _interno, _capacidad);
    var data = json.decode(response.body);

    http.Response responseBus = await LineaController.getBus();
    var dataBus = json.decode(responseBus.body);

    if (response.statusCode == 401) {
      interno = dataBus['interno'];
      placa = dataBus['placa'];
      modelo = dataBus['modelo'];
      capacidad = dataBus['capacidad'];
      servicios = dataBus['servicios'];
      lineaName = dataBus['linea'];

      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/mapa_login.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          TypeAheadFormField<Linea?>(
                            key: _formKey,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _typeAheadController,
                              decoration: const InputDecoration(
                                hintText: 'Seleccione una línea'
                              )
                            ),
                            suggestionsCallback: LineaController.getLineaSuggestion, 
                            itemBuilder: (context, Linea? suggestion) {
                              final linea = suggestion!;
                              return ListTile(
                                title: Text(linea.linea),
                              );
                            }, 
                            noItemsFoundBuilder: (context) => const SizedBox(
                              height: 100,
                              child: Text(
                                'No se encontró la línea', 
                                style: TextStyle(fontSize: 24),
                              )
                            ),
                            transitionBuilder: (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (Linea? suggestion) {
                              final linea = suggestion!;
                              _typeAheadController.text = suggestion.linea;
                              setState(() {                             
                                idLinea = linea.id;
                                lineaName = linea.linea;
                              });
                              // ignore: avoid_print
                              print('Linea id: $idLinea');
                            },  
                            onSaved: (value) => idLinea = value as int,                         
                          ),
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Interno'),
                            onChanged: (value) {
                              _interno = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(                           
                            decoration: const InputDecoration(hintText: 'Placa'),
                            onChanged: (value) {
                              _placa = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(                           
                            decoration: const InputDecoration(hintText: 'Modelo'),
                            onChanged: (value) {
                              _modelo = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(                           
                            decoration: const InputDecoration(hintText: 'Servicios'),
                            onChanged: (value) {
                              _servicios = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(                           
                            decoration: const InputDecoration(hintText: 'Capacidad'),
                            onChanged: (value) {
                              _capacidad = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          RoundedButton(
                            btnText: 'Sign Up', 
                            onBtnPressed: () => createBusPressed(),
                          ),
                          const SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}