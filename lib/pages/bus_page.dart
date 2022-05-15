import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/models/linea.dart';
import 'package:rutas_microbuses/pages/chofer_page.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/services/api.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);
  
  @override
  _BusPageState createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  String _linea = '';
  String _interno = '';
  String _placa = '';
  String _modelo = '';
  String _servicios = '';
  String _capacidad = '';
  var lineas = <Linea>[];

  @override
  void initState() {
    _getLineas();
    super.initState();
  }

  _getLineas() async {
    await _initData();
  }

  _initData() async {
    await CallApi().getPublicData("lineas").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        lineas = list.map((model) => Linea.fromJson(model)).toList();
      });
    });
  }

  createBusPressed() async {
    
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
                          DropdownButton(
                            items: lineas.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.linea),
                                value: item.id.toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                _linea = newVal.toString();
                              });
                            },
                            value: _linea,
                            hint: const Text("Seleccione una línea")
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