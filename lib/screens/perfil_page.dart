// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/conductor.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/screens/micro_page.dart';
import 'package:rutas_microbuses/services/conductor_service.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';

class PerfilPage extends StatefulWidget{
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Conductor? driver;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getUser() async {
    ApiResponse response = await getConductorDetail();
    if(response.error == null) {
      setState(() {
        driver = response.data as Conductor;
        idConductor = driver!.id!;
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

  @override
  void initState() {
    getUser();
    super.initState();
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
                      title: const Text(
                        'Nombre Completo:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${driver!.name}',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      leading: const Icon(Icons.person),
                    ),
                    ListTile(
                      title: const Text(
                        'Correo electrónico:  ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${driver!.email}',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      leading: const Icon(Icons.email),
                    ), 
                    ListTile(
                      title: const Text(
                        'Fecha de nacimiento:  ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${driver!.birthday}',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      leading: const Icon(Icons.calendar_month),
                    ),
                    ListTile(
                      title: const Text(
                        'Carnet de Identidad:  ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${driver!.ci}',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      leading: const Icon(Icons.card_membership),
                    ),
                    ListTile(
                      title: const Text(
                        'Celular:  ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${driver!.telefono}',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      leading: const Icon(Icons.numbers),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> const MicroPage()), 
                  );
                },
                child: const Text(
                  'Ver Micro', 
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );              
  }
}