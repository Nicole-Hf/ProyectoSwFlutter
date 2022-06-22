import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/bus_page.dart';
import 'package:rutas_microbuses/pages/conductor_page.dart';
import 'package:rutas_microbuses/pages/microbus_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class ConductorPage extends StatefulWidget {
  const ConductorPage({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _ConductorPageState createState() => _ConductorPageState();
}

class _ConductorPageState extends State<ConductorPage> {
  String _name= '';
  String _fechanacimiento= '';
  String _ci= '';
  String _telefono= '';
  String _categorialic= '';

  createAccountPressed() async {
      http.Response response = await AuthServices.conductorRegister(_name, _fechanacimiento, _ci, _telefono, _categorialic);
      Map responseMap = jsonDecode(response.body);
      var dataUser = json.decode(response.body);
      if (response.statusCode == 401) {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => const MicrobusPage(),
        ));
      } else {
          // ignore: use_build_context_synchronously
          errorSnackBar(context, responseMap.values.first[0]);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/mapa_login.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Username'),
                            onChanged: (value) {
                              _name = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Fecha de Nacimiento'),
                            onChanged: (value) {
                              _fechanacimiento = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Telefono'),
                            onChanged: (value) {
                              _telefono = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Categoria Licencia'),
                            onChanged: (value) {
                              _categorialic = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Carnet'),
                            onChanged: (value) {
                              _ci = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          RoundedButton(
                            btnText: 'Next Page',
                            onBtnPressed: () => createAccountPressed(),
                          ),
                          const SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}