// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/conductor.dart';
import 'package:rutas_microbuses/screens/perfil_page.dart';
import 'package:rutas_microbuses/services/conductor_service.dart';
import 'package:rutas_microbuses/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDriver extends StatefulWidget {
  const LoginDriver({Key? key}) : super(key: key);

  @override
  State<LoginDriver> createState() => _LoginDriverState();
}

class _LoginDriverState extends State<LoginDriver> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  bool loading = false;
  bool passwordVisibility = false;

  void _loginUser() async {
    ApiResponse response = await loginDriver(txtEmailController.text, txtPasswordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as Conductor);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}'))
      );
    }
  }

  void _saveAndRedirectToHome(Conductor conductor) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('email', conductor.email ?? '');
    await preferences.setInt('conductorId', conductor.id ?? 0);
    idConductor = conductor.id!;
    debugPrint('Conductor ID: $idConductor');
    
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PerfilPage(),), 
    );
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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 300, 20, 0),
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
                      hintText: 'Ingresa tu email...',
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
                    obscureText: !passwordVisibility,
                    controller: txtPasswordController,
                    validator: (val) => val!.length < 6 ? 'Required at least 6 chars' : null,
                    decoration: InputDecoration(
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
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: 'Ingresa tu contraseña...',
                      hintStyle: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2, 
                          color: Color(0xFFDBE2E7)
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    )
                  ),
                  const SizedBox(height: 30,),
                  loading ? const Center(child: CircularProgressIndicator(),)
                  : ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _loginUser();
                      }
                    },
                    style: ButtonStyle(   
                      elevation: MaterialStateProperty.resolveWith((states) => 2),             
                      backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 58, 170, 60)),
                      side: MaterialStateProperty.resolveWith((states) => 
                        const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        )
                      ),
                      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsetsDirectional.fromSTEB(50, 15, 50, 15)),
                    ), 
                    child: const Text('Login', 
                      style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),                  
                ]
              )
            ),
          )
        ]
      )
    );
  }
}