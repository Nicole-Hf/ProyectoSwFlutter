import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/conductor_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name = '';
  String _email = '';
  String _password = '';

  createAccountPressed() async {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
    
    if (emailValid) {
      http.Response response = await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      var dataUser = json.decode(response.body);
      if (response.statusCode == 401) {
        idUser = dataUser['user']['id'];
        username = dataUser['user']['name'];
        // ignore: avoid_print
        print('Conductor id: $idConductor');
        // ignore: use_build_context_synchronously
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => const ConductorPage(),
        ));
      } else {
          // ignore: use_build_context_synchronously
          errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
        errorSnackBar(context, 'Email not valid');
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
                            decoration: const InputDecoration(hintText: 'Email'),
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextField(
                            obscureText: true,
                            decoration: const InputDecoration(hintText: 'Password'),
                            onChanged: (value) {
                              _password = value;
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