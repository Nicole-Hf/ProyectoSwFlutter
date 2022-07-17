import 'package:flutter/material.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/screens/micro_page.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

class FinishTracking extends StatefulWidget {
  const FinishTracking({Key? key}) : super(key: key);

  @override
  State<FinishTracking> createState() => _FinishTrackingState();
}

class _FinishTrackingState extends State<FinishTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,       
        elevation: 10,
        toolbarHeight: 70,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => const MicroPage(),)
            );
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: const Text('Terminar recorrido', style: TextStyle(color: Colors.black),),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                        'Hora de Salida:  $horaSalida',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.person),
                    ),
                    ListTile(
                      title: Text(
                        'Hora de Llegada:  $horaRetiro',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.bus_alert),
                    ),
                    ListTile(
                      title: Text(
                        'Tiempo transcurrido:  $tiempoUpd',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.numbers),
                    ),
                    ListTile(
                      title: Text(
                        'Retraso:  $retraso',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: const Icon(Icons.label_important),
                    ),
                  ],
                ),
              ),
            ]
          )
        ]
      )
    );
  }
}