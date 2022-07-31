// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/bus.dart';
import 'package:rutas_microbuses/routes/lineas/rutas.dart';
import 'package:rutas_microbuses/routes/points/linea01.dart';
import 'package:rutas_microbuses/routes/points/linea02.dart';
import 'package:rutas_microbuses/routes/points/linea05.dart';
import 'package:rutas_microbuses/routes/points/linea08.dart';
import 'package:rutas_microbuses/routes/points/linea09.dart';
import 'package:rutas_microbuses/routes/points/linea10.dart';
import 'package:rutas_microbuses/routes/points/linea11.dart';
import 'package:rutas_microbuses/routes/points/linea16.dart';
import 'package:rutas_microbuses/routes/points/linea17.dart';
import 'package:rutas_microbuses/routes/points/linea18.dart';
import 'package:rutas_microbuses/routes/polylines/linea01.dart';
import 'package:rutas_microbuses/routes/polylines/linea02.dart';
import 'package:rutas_microbuses/routes/polylines/linea05.dart';
import 'package:rutas_microbuses/routes/polylines/linea08.dart';
import 'package:rutas_microbuses/routes/polylines/linea09.dart';
import 'package:rutas_microbuses/routes/polylines/linea10.dart';
import 'package:rutas_microbuses/routes/polylines/linea11.dart';
import 'package:rutas_microbuses/routes/polylines/linea16.dart';
import 'package:rutas_microbuses/routes/polylines/linea17.dart';
import 'package:rutas_microbuses/routes/polylines/linea18.dart';
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
  LocationData? currentLocation;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  double? _latitud, _longitud;

  @override
  void initState() {
    getBus();
    permissions();
    getCurrentLocation();
    super.initState();
  }

  Future<void> permissions() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
    currentLocation = await location.getLocation();
    setState(() {});
  }

  Future<void> getCurrentLocation() async {
    location.getLocation().then((location) {
      currentLocation = location;
      _latitud = currentLocation!.latitude;
      _longitud = currentLocation!.longitude;
      debugPrint('UBICACION: $currentLocation');
    });
  }

  void getBus() async {
    ApiResponse response = await getBusDetail();
    if(response.error == null) {
      setState(() {
        bus = response.data as Bus;
        lineaMicro = bus!.linea;
        debugPrint("LINEA: $lineaMicro");
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
    http.Response response = await createRecorrido(_tipo, _latitud, _longitud);
    var data = json.decode(response.body);
    debugPrint('Id conductor nuevo: $idConductor');
    debugPrint('BODY RECORRIDO: ${response.body}');
    if (response.statusCode == 200) { 
      idRecorrido = data['recorrido']['id'];   
      fecha = data['recorrido']['fecha'];
      tipo = data['recorrido']['tipo'];
      horaSalida = data['recorrido']['horaSalida']; 
      horaLlegada = data['recorrido']['horaLLegada'];
      tiempo = data['recorrido']['tiempo'];
      
      final List<Ida> ida = [
      Ida("Línea 1", linea01.first),
      Ida("Línea 2", linea02.first),
      Ida("Línea 5", linea05.first),
      Ida("Línea 8", linea08.first),
      Ida("Línea 9", linea09.first),
      Ida("Línea 10", linea10.first),
      Ida("Línea 11", linea11.first),
      Ida("Línea 16", linea16.first),
      Ida("Línea 17", linea17.first),
      Ida("Línea 18", linea18.first),
    ];

    final List<Vuelta> vuelta = [
      Vuelta("Línea 1", linea01.last),
      Vuelta("Línea 2", linea02.last),
      Vuelta("Línea 5", linea05.last),
      Vuelta("Línea 8", linea08.last),
      Vuelta("Línea 9", linea09.last),
      Vuelta("Línea 10", linea10.last),
      Vuelta("Línea 11", linea11.last),
      Vuelta("Línea 16", linea16.last),
      Vuelta("Línea 17", linea17.last),
      Vuelta("Línea 18", linea18.last),
    ];

    if (tipo == "ida") {
      for (int i = 0; i < ida.length; i++) {
        if (lineaMicro == ida[i].name) {
          Set<Polyline> linea = {
            ida[i].ini
          };
          Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => 
        TrackingPage(linea: linea, inicio: ida[i].ini.points.first, fin: ida[i].ini.points.last),)
      );
        }
      }
    } else if (tipo == "vuelta") {
      for (int i = 0; i < vuelta.length; i++) {
        if (lineaMicro == vuelta[i].name) {
          Set<Polyline> linea = {
            vuelta[i].fin
          };
          Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => 
        TrackingPage(linea: linea, inicio: vuelta[i].fin.points.first, fin: vuelta[i].fin.points.last),)
      );
        }
      }
    }
    }
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
        //drawer: const MenuWidget(),
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