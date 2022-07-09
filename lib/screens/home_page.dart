// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/tracking_page.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/services/recorrido_service.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/button.dart';
import 'package:rutas_microbuses/variables.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _tipo;

  createRecorridoPressed() async {
    http.Response response = await RecorridoController.createRecorrido(_tipo);
    var data = json.decode(response.body);
    if (response.statusCode == 200) { 
      idRecorrido = data['id']; 
      debugPrint('Recorrido: $idRecorrido');   
      fecha = data['fecha'];
      tipo = data['tipo'];
      horaSalida = data['horaSalida']; 
      horaLlegada = data['horaLLegada'];
      tiempo = data['tiempo'];

      Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const TrackingPage(),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,       
        elevation: 10,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Image.asset("assets/images/app_icon.png",)
        ),
        centerTitle: true,
        title: const Text('App Conductor', style: TextStyle(color: Colors.black),),
        actions: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.logout, size: 25, color: Colors.black,),
              onPressed: () {
                logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login(),), (route) => false);
                });
              },
            ),
          ),
          const SizedBox(width: 26)
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[       
          Column(
            children: <Widget>[
              /*fotoMicro != null ?
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: 300,
                  height: 180,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(                     
                      image: NetworkImage(fotoMicro),
                      fit: BoxFit.cover
                    )
                  ),
                ) : SizedBox(height: fotoMicro != null ? 0 : 10,),
              const SizedBox(height: 20,),
              Card(
                margin: const EdgeInsets.only(left: 10, right: 10),
                elevation: 10,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Conductor:  $nombreConductor',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.person),
                    ),
                    ListTile(
                      title: Text(
                        'Línea:  $lineaName',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.bus_alert),
                    ),
                    ListTile(
                      title: Text(
                        'Interno:  $interno',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.numbers),
                    ),
                    ListTile(
                      title: Text(
                        'Placa:  $placa',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.label_important),
                    ),
                    ListTile(
                      title: Text(
                        'Modelo:  $modelo',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.model_training),
                    ),
                    ListTile(
                      title: Text(
                        'Número de Asientos:  $capacidad',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.group),
                    ),
                  ],
                ),
              ),*/
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(                        
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 4.5,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0x00ffffff),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Seleccione un recorrido'),
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ChoiceChip(                   
                                        label: const Text('Ida',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15)
                                        ),
                                        labelPadding: const EdgeInsets.symmetric(horizontal: 50),
                                        selected: _tipo == 'ida',
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _tipo = selected ? 'ida' : null;
                                            debugPrint(_tipo);
                                          });
                                        },
                                        selectedColor: const Color.fromARGB(255, 83, 252, 78),
                                        shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                        )
                                      )
                                    ),
                                    Expanded(
                                      child: ChoiceChip(                    
                                        label: const Text('Vuelta',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black, fontSize: 15)
                                        ),
                                        labelPadding: const EdgeInsets.symmetric(horizontal: 50),
                                        selected: _tipo == 'vuelta',
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _tipo = selected ? 'vuelta' : null;
                                            debugPrint(_tipo);
                                          });
                                        },
                                        selectedColor: const Color.fromARGB(255, 83, 252, 78),
                                        shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                        )
                                      )
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 20,),                              
                              RoundedButton(
                                btnText: 'Iniciar Recorrido',
                                onBtnPressed: () => createRecorridoPressed(),
                              ),
                            ]
                          )
                        ),
                      );
                    }
                  );
                },
                child: const Text("Iniciar Recorrido"),
              ),
            ],
          ),
        ],
      )
    );
  }
}