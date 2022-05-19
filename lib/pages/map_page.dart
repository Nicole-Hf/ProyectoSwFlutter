// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:rutas_microbuses/pages/login_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,       
        elevation: 10,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/logo_app.jpeg",)
        ),
        centerTitle: true,
        title: const Text('App Conductor'),
        actions: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.logout, size: 25),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()), 
                  (route) => false
                );
              },
            ),
          ),
          const SizedBox(width: 26)
        ],
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              minZoom: 10.0,
              center: LatLng(40.71, -74.00)
            ),
            layers: [TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [Marker(
                  width: 45.0,
                  height: 45.0,
                  point: LatLng(40.73, -74.00),
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.car_rental), 
                    onPressed: () {
                      // ignore: avoid_print
                      print("Marker tapped!");
                    },),
                )]
              )
            ],
          )
        ]
      )
    );
  }
}