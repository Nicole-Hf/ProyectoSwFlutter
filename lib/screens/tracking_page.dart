// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rutas_microbuses/screens/finish_page.dart';
import 'package:rutas_microbuses/screens/retiro_page.dart';
import 'package:rutas_microbuses/services/recorrido_service.dart';
import 'package:rutas_microbuses/variables.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  Location location = Location();
  LocationData? currentLocation;
  double? _latitud, _longitud;
  final TextEditingController _txtControllerBody = TextEditingController();
  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> getCurrentLocation() async {
    //Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
      _latitud = currentLocation!.latitude;
      _longitud = currentLocation!.longitude;
    });

    GoogleMapController googleMapController = await _controller.future;

    _locationSubscription = location.onLocationChanged.listen((newLoc) async {
      currentLocation = newLoc;
      _latitud = currentLocation!.latitude;
      _longitud = currentLocation!.longitude;
      http.Response response = await editLoc(_latitud, _longitud);
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 14.5,
            target: LatLng(newLoc.latitude!, newLoc.longitude!)
          )
        )
      );
      setState(() {});
    });
  }

  Future<void> _stopLocation() async {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
    http.Response response = await finishRecorrido();
    var data = json.decode(response.body);
    if (response.statusCode == 200) { 
      tiempoUpd = data['recorrido']['tiempo'];
      horaRetiro = data['recorrido']['horaLLegada'];
      retraso = data['recorrido']['retraso'];
      Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const FinishTracking(),)
      );
    }
  }

  Future<void> _saveRetiro() async {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
    http.Response response = await saveRetiro(_txtControllerBody.text);
    var data = json.decode(response.body);
    if (response.statusCode == 200) { 
      idComentario = data['comentario']['id'];   
      motivo = data['comentario']['fecha'];
      horaRetiro = data['comentario']['horaRetiro']; 
      Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const RetiroPage(),)
      );
    }
  }

  @override
  void initState() {
    getCurrentLocation();
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
        title: const Text('Recorrido', style: TextStyle(color: Colors.black),),
      ),
      body: Stack(
        children: [
          currentLocation == null
          ? const Center(child: Text("Loading"),)
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 14.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
                ),               
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
          Align(
            alignment: const AlignmentDirectional(0, 1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 25, 44),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(17, 12, 12, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recorrido de $tipo',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.green
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              'Fecha:  $fecha',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              'Hora de salida:  $horaSalida',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              'Hora de llegada estimada:  $horaLlegada',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              'Tiempo estimado:  $tiempo',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                              ),
                            ), 
                            const SizedBox(height: 15,),
                            ElevatedButton(
                              onPressed: (){
                                _stopLocation();
                              }, 
                              child: const Text('Terminar Recorrido')
                            ),
                            ElevatedButton(
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Container(                        
                                        width: MediaQuery.of(context).size.width / 1.3,
                                        height: MediaQuery.of(context).size.height / 2.5,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Color(0x00ffffff),
                                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            const Text('Salir del recorrido'),
                                            const SizedBox(height: 20,),
                                            TextFormField(
                                              controller: _txtControllerBody,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: 9,
                                              validator: (val) => val!.isEmpty ? 'Este campo es requerido' : null,
                                              decoration: const InputDecoration(
                                                hintText: "Ingrese el motivo de la salida...",
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1, 
                                                    color: Colors.black38
                                                  )
                                                )
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                _saveRetiro();                              
                                              },
                                              child: const Text('Enviar'),
                                            ),                             
                                          ]
                                        )
                                      ),
                                    );
                                  }
                                );
                              }, 
                              child: const Text('Salir del Recorrido')
                            )                     
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}