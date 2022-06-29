// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/user.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/screens/register.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmailController.text, txtPasswordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}'))
      );
    }
  }

  void _saveAndRedirectToHome(User user) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', user.token ?? '');
    await preferences.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage(),), (route) => false);
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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 300, 0, 0),
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [           
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmailController,
                    validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Correo electrónico',
                      labelStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: 'Enter your email here...',
                      hintStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2, 
                          color: Color(0xFFDBE2E7)
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      )
                    )
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    controller: txtPasswordController,
                    validator: (val) => val!.length < 6 ? 'Required at least 6 chars' : null,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1, 
                          color: Colors.black
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 10,),
                  loading ? const Center(child: CircularProgressIndicator(),)
                  : TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _loginUser();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10)),
                    ), 
                    child: const Text('Login', style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No tienes una cuenta? '),
                      GestureDetector(
                        child: const Text('Registrate aquí', style: TextStyle(color: Colors.blue),),
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Register(),), (route) => false);
                        },
                      )
                    ],
                  )
                ]
              )
            ),
          )
        ]
      )                                           
    );
  }
}