// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                /*Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Login()), 
                  (route) => false
                );*/
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
        //fit: StackFit.expand,
        children: <Widget>[       
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
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
                ) : SizedBox(height: fotoMicro != null ? 0 : 10,),*/
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
              ),
              const SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {
                  debugPrint('Button cliked');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[                    
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Iniciar Recorrido', 
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),      
              ),
            ],
          ),
        ],
      )
    );
  }
}