// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/user.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse response = await register(txtNameController.text, txtEmailController.text, txtPasswordController.text);
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
          Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [  
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: txtNameController,
                  validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                  decoration: const InputDecoration(
                    labelText: 'Username',
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmailController,
                  validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
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
                      _registerUser();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green),
                    padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10)),
                  ), 
                  child: const Text('Register', style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ya tienes una cuenta? '),
                    GestureDetector(
                      child: const Text('Login', style: TextStyle(color: Colors.blue),),
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Register(),), (route) => false);
                      },
                    )
                  ],
                )
              ]
            )
          )
        ]
      )                                           
    );
  }
}