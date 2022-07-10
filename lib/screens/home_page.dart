// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/bus.dart';
import 'package:rutas_microbuses/pages/tracking_page.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/services/linea_controller.dart';
import 'package:rutas_microbuses/services/recorrido_service.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _busList = [];
  int userId = 0;
  bool _loading = true;
  String? _tipo;

  Future<void> retrieveBus() async {
    userId = await getUserId();
    ApiResponse response = await getBusToday();

    if (response.error == null) {
      setState(() {
        _busList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Login()), 
          (route) => false
        )
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

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
  void initState() {
    retrieveBus();
    super.initState();
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: _loading 
                      ? const Center(child: CircularProgressIndicator(),)
                      : RefreshIndicator(
                          onRefresh: () {
                            return retrieveBus();
                          },
                          child: ListView.builder(
                            itemCount: _busList.length,
                            itemBuilder: (context, index) {
                              Bus bus = _busList[index];
                              return Column(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        image: bus.foto != null
                                        ? DecorationImage(
                                            image: NetworkImage('${bus.foto}')
                                          ) 
                                        : null,
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.amber
                                      ),
                                    ),
                                    Card(
                                      margin: const EdgeInsets.only(left: 10, right: 10),
                                      elevation: 10,
                                      shadowColor: Colors.grey.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Conductor: ${bus.conductor}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            leading: const Icon(Icons.person),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Línea:  ${bus.linea}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            leading: const Icon(Icons.bus_alert),
                                          ), 
                                          ListTile(
                                            title: Text(
                                              'Interno:  ${bus.interno}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            leading: const Icon(Icons.numbers),
                                          ), 
                                          ListTile(
                                            title: Text(
                                              'Placa:  ${bus.placa}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            leading: const Icon(Icons.label_important),
                                          ), 
                                          ListTile(
                                            title: Text(
                                              'Modelo:  ${bus.modelo}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            leading: const Icon(Icons.model_training),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Número de asientos:  ${bus.capacidad}',
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            leading: const Icon(Icons.group),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                              );
                            },
                          ), 
                        ),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('Button');
              }, 
              child: const Text('Iniciar Recorrido')
            )
          ],
        ),
      ),
    );
                
  }
}