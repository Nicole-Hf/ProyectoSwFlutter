// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/drawer_widget.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/bus.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/screens/tracking_page.dart';
import 'package:rutas_microbuses/services/linea_controller.dart';
import 'package:rutas_microbuses/services/recorrido_service.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

class MicroPage extends StatefulWidget{
  const MicroPage({Key? key}) : super(key: key);

  @override
  _MicroPageState createState() => _MicroPageState();
}

class _MicroPageState extends State<MicroPage> {
  Bus? bus;
  bool loading = true;
  String? _tipo;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getBus() async {
    ApiResponse response = await getBusDetail();
    if(response.error == null) {
      setState(() {
        bus = response.data as Bus;
        loading = false;
      });
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context)=> const Login()), 
          (route) => false
        )
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  createRecorridoPressed() async {
    http.Response response = await createRecorrido(_tipo);
    var data = json.decode(response.body);
    debugPrint('Id conductor nuevo: $idConductor');
    debugPrint('Body Tracking: ${response.body}');
    if (response.statusCode == 200) { 
      idRecorrido = data['recorrido']['id'];   
      fecha = data['recorrido']['fecha'];
      tipo = data['recorrido']['tipo'];
      horaSalida = data['recorrido']['horaSalida']; 
      horaLlegada = data['recorrido']['horaLLegada'];
      tiempo = data['recorrido']['tiempo'];

      Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const TrackingPage(),)
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getBus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,       
          elevation: 10,
          toolbarHeight: 70,
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
        drawer: const MenuWidget(),
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.only(left: 10, right: 10),
                elevation: 10,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Conductor: ${bus!.conductor}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.person),
                    ),
                    ListTile(
                      title: Text(
                        'Línea:  ${bus!.linea}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.bus_alert),
                    ), 
                    ListTile(
                      title: Text(
                        'Interno:  ${bus!.interno}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.numbers),
                    ), 
                    ListTile(
                      title: Text(
                        'Placa:  ${bus!.placa}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.label_important),
                    ), 
                    ListTile(
                      title: Text(
                        'Modelo:  ${bus!.modelo}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.model_training),
                    ),
                    ListTile(
                      title: Text(
                        'Número de asientos:  ${bus!.capacidad}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.group),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
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
                            debugPrint('Tipo $_tipo');                       
                          });
                        },
                        selectedColor: const Color.fromARGB(255, 19, 135, 15),
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
                            debugPrint('Tipo $_tipo');
                          });
                        },
                        selectedColor: const Color.fromARGB(255, 19, 135, 15),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        )
                      )
                    ),
                  ]
                )
              ),
              const SizedBox(height: 20,),                              
              ElevatedButton(
                onPressed: () {
                  createRecorridoPressed();
                },
                child: const Text('Iniciar recorrido'),
              ),
            ],
          ),
        ),
      ),
    );              
  }
}