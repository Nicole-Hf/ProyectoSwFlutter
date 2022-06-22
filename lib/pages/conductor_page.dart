
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/microbus_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';

import '../services/globals.dart';

class conductorpage extends StatefulWidget {
  const conductorpage({Key? key}) : super(key: key);

  @override
  State<conductorpage> createState() => _conductorpageState();
}



class _conductorpageState extends State<conductorpage> {
  String _name= '';
  String _fechanacimiento= '';
  String _ci= '';
  String _telefono= '';
  String _categorialic= '';

  createAccountPressed() async {
      http.Response response = await AuthServices.conductorRegister(_name, _fechanacimiento,
          _ci,_telefono,_categorialic,);
      Map responseMap = jsonDecode(response.body);
      var dataUser = json.decode(response.body);
      if (response.statusCode == 401) {
        print("datos registrados");
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
       appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          //title: Text('Perfil Conductor'),
        leading: IconButton(
            icon: const Icon(
              Icons.account_box,
              color: Colors.green,
            ),
          onPressed: (){},
        ),
         actions: [
           IconButton(
             icon: const Icon(
               Icons.settings,
               color: Colors.green,
             ),
             onPressed: (){},
           ),
         ],


       ),

      body: Container(
        padding: const EdgeInsets.only(left: 16,top: 25,right: 16),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text("Perfil",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
              ),
               Center(
                 child: Stack(
                   children: [
                     Container(
                       width: 130,
                       height: 130,
                       decoration: BoxDecoration(
                         border: Border.all(width: 4,color: Colors.white),
                         boxShadow: [
                           BoxShadow(
                             spreadRadius: 2,
                             blurRadius: 10,
                             color: Colors.black.withOpacity(0.1)
                           )
                         ],
                         shape: BoxShape.circle,
                         image: const DecorationImage(
                             fit:  BoxFit.cover,
                             image: AssetImage("assets/images/frozen.jpg"),
                         )
                       ),
                     ),
                     Positioned(
                         bottom: 0,
                         right: 0,
                         child: Container(
                           height: 40,
                           width: 40,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(
                               width: 4,
                               color: Colors.white
                             ),
                             color: Colors.green
                           ),
                           child: const Icon(
                             Icons.edit,
                           color: Colors.white,
                           ),
                         )
                     )
                   ],
                 ),
               ),

              Column(
                children: [
                  const SizedBox(height: 20,),
                  TextField(
                    decoration: const InputDecoration(hintText: 'nombre completo'),
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    decoration: const InputDecoration(hintText: 'fecha Nacimiento'),
                    onChanged: (value) {
                      _fechanacimiento = value;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    decoration: const InputDecoration(hintText: 'carnet identidad'),
                    onChanged: (value) {
                      _ci = value;
                    },
                  ),

                  const SizedBox(height: 20,),
                  TextField(
                    decoration: const InputDecoration(hintText: 'telefono'),
                    onChanged: (value) {
                      _telefono = value;
                    },
                  ),

                  const SizedBox(height: 20,),
                  TextField(
                    decoration: const InputDecoration(hintText: 'categoria licencia'),
                    onChanged: (value) {
                      _categorialic = value;
                    },
                  ),
                  const SizedBox(height: 20,),

                ],
              ),
            /*  buildTextField("nombre completo", "ejm: Juan Perez",_name),
              buildTextField("fecha Nacimiento", "ejm: año/mes/dia",_fechanacimiento),
              buildTextField("carnet identidad", "ejm: 11223345",_ci),
              buildTextField("telefono", "ejm: 78903442",_telefono),
              buildTextField("categoria licencia", "ejm: A",_categorialic),
              const SizedBox(height: 30),
*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*OutlinedButton(onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                      child: const Text("CANCEL", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                      )),
                      ),*/
                  ElevatedButton(
                    onPressed: () => createAccountPressed(),
                    style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                  ),
                    child: const Text("siguiente", style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.white
                  )),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

 Widget buildTextField(String labelText, String placeholder, String valor){
    String valorcito = valor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        //obscureText: isPasswordTextField ? isObscurePassword: false,
        decoration: InputDecoration(
          /*suffixIcon: isObscurePassword ?
              IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                onPressed: (){},
              ):null,*/
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        onChanged: (value) {
          if(valorcito == null) {
            print(valorcito);
          }else{
            print("no hay valor");
          }
          valorcito = value;
        },

      ),

    );
 }

}


