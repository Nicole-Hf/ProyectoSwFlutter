// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/services/linea_controller.dart';
import 'package:rutas_microbuses/pages/register_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/utils/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  bool passwordVisibility = false;

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      var dataUser = json.decode(response.body);

      if (response.statusCode == 200) {
        idConductor = dataUser['user']['conductor_id'];

        http.Response responseBus = await LineaController.getBus();
        var dataBus = json.decode(responseBus.body);

        interno = dataBus['interno'];
        placa = dataBus['placa'];
        modelo = dataBus['modelo'];
        capacidad = dataBus['capacidad'];
        lineaName = dataBus['linea'];
        print('Conductor id: $idConductor');
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => const HomePage(),
        ));       
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'Enter all required fields');
    }
  }

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/train_image.jpg"),
              fit: BoxFit.cover
            )
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        TextField(
                          decoration: const InputDecoration(hintText: 'Correo electrónico'),
                          onChanged: (value) { _email = value; },
                        ),
                        const SizedBox(height: 30,),
                        TextField(
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordVisibility = !passwordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                  color: const Color(0xFF95A1AC),
                                  size: 22,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              _password = value;
                            },
                          ),
                        const SizedBox(height: 30,),
                        RoundedButton(
                          btnText: 'Ingresar',
                          onBtnPressed: () => loginPressed(),
                        ),
                        const SizedBox(height: 30,),                
                      ],
                    )
                  ),
                ),
                const SizedBox(height: 30,),    
                const Text(
                  '¿No tienes una cuenta?', 
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ), 
                const SizedBox(height: 10,),            
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (BuildContext context) => const RegisterPage())
                    );
                  },
                  child: const Text(
                    'Registrate aquí',
                      style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 22),
                  )
                ),
                const SizedBox(height: 30,),
              ],
            ),
          )
        )
      ],
    ));
  }
}