// ignore_for_file: avoid_function_literals_in_foreach_calls, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rutas_microbuses/variables.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  double? _latitud, _longitud;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
      debugPrint('Ubicacion actual: $currentLocation');
      _latitud = currentLocation!.latitude;
      _longitud = currentLocation!.longitude;
      debugPrint('Latitud $_latitud Longitud $_longitud');
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      /*http.Response response = await RecorridoController.saveLocation(_latitud, _longitud);
      debugPrint('Ubicacion nueva: $currentLocation');
      debugPrint('Response: ${response.body}');*/
      
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(newLoc.latitude!, newLoc.longitude!)
          )
        )
      );

      setState(() {
        
      });
    });
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
        title: const Text("Tracking",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
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
                              onPressed: (){}, 
                              child: const Text('Terminar Recorrido')
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