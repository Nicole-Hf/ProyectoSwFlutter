// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:rutas_microbuses/pages/login_page.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location location = Location();

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
                    (route) => false);
                },
              ),
            ),
            const SizedBox(width: 26)
          ],
        ),
        body: Stack(children: <Widget>[
          StreamBuilder(
            stream: location.onLocationChanged(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                var data = snapshot.data as LocationData;
                latitud = data.latitude;
                longitud = data.longitude;
                return FlutterMap(
            options:
                MapOptions(minZoom: 10.0, center: LatLng(latitud, longitud)),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(markers: [
                Marker(
                  width: 45.0,
                  height: 45.0,
                  point: LatLng(latitud, longitud),
                  builder: (context) => Image.asset(
                    'assets/images/ubt_icon.png', 
                    height: 20.0, 
                    width: 20.0,
                  ),
                )
              ])
            ],
          );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ]));
  }
}
