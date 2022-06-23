// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // Location location = Location();
  /*Location location = Location();
  late bool _serviceEnabled;
  //late PermissionStatus _permissionGranted;
  //late LocationData _locationData;
  // ignore: unused_field
  bool _isListenLocation = false; //, _isGetLocation = false;*/
  
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
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: const <Widget>[       
     /*     Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.only(left: 10, right: 10),
                elevation: 10,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Línea:  $lineaName',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        'Interno:  $interno',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        'Placa:  $placa',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        'Modelo:  $modelo',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        'Servicios:  $servicios',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        'Número de Asientos:  $capacidad',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              // ignore: deprecated_member_use
              ElevatedButton(
                onPressed: () {
                  debugPrint('Button cliked');
                },
                // ignore: sort_child_properties_last
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/bus_icon.jpg', height: 40.0, width: 40.0,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Iniciar Recorrido', 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),      
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                child: Column(
                  children: [
                    // ignore: deprecated_member_use
                    ElevatedButton(
                      onPressed: () async {
                        _serviceEnabled = await location.serviceEnabled();
                        if (!_serviceEnabled) {
                          _serviceEnabled = await location.requestService();
                          if (_serviceEnabled) {
                            return;
                          }
                        }
                        _permissionGranted = await location.hasPermission();
                        if (_permissionGranted == PermissionStatus.denied) {
                          _permissionGranted = await location.requestPermission();
                          if (_permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }
                        setState(() {
                          _isListenLocation = true;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => const MapPage(),));
                      },
                      // ignore: sort_child_properties_last
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset('assets/images/ubt_icon.png', height: 40.0, width: 40.0,),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('Ir al Mapa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: location.onLocationChanged,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.waiting) {
                          var data = snapshot.data as LocationData;
                          latitud = data.latitude!;
                          longitud = data.longitude!;
                          return Text('Location always change: \n ${data.latitude}/${data.longitude}');
                        } else {
                            return const Center();
                        }
                      }
                    )
                  ]
                )
              )  */
            ],
          ),    */
        ],
      )
    );
  }
}