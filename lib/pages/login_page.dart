import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/chofer_page.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/pages/register_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      var dataUser = json.decode(response.body);
      if (response.statusCode == 200) {
        user_type = dataUser['user']['tipo'];
        if (user_type == 'pasajero') {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (BuildContext context) => const HomePage(),
          ));
        } else {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (BuildContext context) => const HomeChoferPage(),
          ));
        }       
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'Enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        TextField(
                          decoration: const InputDecoration(hintText: 'Enter your email'),
                          onChanged: (value) { _email = value; },
                        ),
                        const SizedBox(height: 30,),
                        TextField(
                          obscureText: true,
                          decoration: const InputDecoration(hintText: 'Enter your password'),
                          onChanged: (value) { _password = value;}
                        ),
                        const SizedBox(height: 30,),
                        RoundedButton(
                          btnText: 'Sig in', 
                          onBtnPressed: () => loginPressed(),
                        ),
                        const SizedBox(height: 30,),                
                      ],
                    )
                  ),
                ),
                const SizedBox(height: 30,),                
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (BuildContext context) => const RegisterPage())
                    );
                  },
                  child: const Text(
                    'Do not have an account? Register here',
                      style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 18),
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