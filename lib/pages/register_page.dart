// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/conductor_page.dart';
import 'package:rutas_microbuses/pages/login_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name = '';
  String _email = '';
  String _password = '';
  bool passwordVisibility = false;

  createAccountPressed() async {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
    if (emailValid) {
      http.Response response = await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      var dataUser = json.decode(response.body);
      if (response.statusCode == 401) {
        idUser = dataUser['user']['id'];
        username = dataUser['user']['name'];
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => const ConductorPage(),
        ));
      } else {
          errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
        errorSnackBar(context, 'Email not valid');
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
      body: Stack(
        children: <Widget>[
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
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Nombre de usuario'),
                            onChanged: (value) {
                              _name = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(
                            decoration: const InputDecoration(hintText: 'Correo electrónico'),
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                          const SizedBox(height: 20,),
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
                          const SizedBox(height: 20,),
                          RoundedButton(
                            btnText: 'Crear cuenta',
                            onBtnPressed: () => createAccountPressed(),
                          ),
                          const SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,), 
                  const Text(
                    '¿Ya tienes una cuenta?', 
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),  
                  const SizedBox(height: 10,),            
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (BuildContext context) => const LoginPage())
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 22),
                    )
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}