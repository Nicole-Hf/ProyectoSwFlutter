import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/pages/microbus_page.dart';
import 'package:rutas_microbuses/pages/conductor_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';

import 'map_page.dart';
class MicrobusPage extends StatefulWidget {
  const MicrobusPage({Key? key}) : super(key: key);

  @override
  State<MicrobusPage> createState() => _MicrobusPageState();
}

class _MicrobusPageState extends State<MicrobusPage> {
  String _placa= '';
  String _modelo= '';
  String _nro_asientos= '';
  String _nro_linea= '';
  String _nroInterno= '';
  String _fecha_asignacion= '';
  String _fecha_baja= '';

  createAccountPressed() async {
    http.Response response = await AuthServices.microbusRegister(_placa,_modelo,_nro_asientos,_nro_linea,
        _nroInterno,_fecha_asignacion,_fecha_baja);
    Map responseMap = jsonDecode(response.body);
    var dataUser = json.decode(response.body);
    if (response.statusCode == 401) {
      print("datos registrados");
      Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const MapPage(),
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
    const Text("Perfil Microbus",
    style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
    ),
    Center(
    child: Stack(
    children: [
    Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
    border: Border.all(width: 4,color: Colors.white),
    boxShadow: [
    BoxShadow(
    spreadRadius: 2,
    blurRadius: 10,
    color: Colors.black.withOpacity(0.1)
    )
    ],
    shape: BoxShape.rectangle,
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
              Icons.camera_alt_rounded,
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
            decoration: const InputDecoration(hintText: 'placa'),
            onChanged: (value) {
              _placa = value;
            },
          ),
          const SizedBox(height: 20,),
          TextField(
            decoration: const InputDecoration(hintText: 'modelo'),
            onChanged: (value) {
              _modelo = value;
            },
          ),
          const SizedBox(height: 20,),
          TextField(
            decoration: const InputDecoration(hintText: 'numero de asientos'),
            onChanged: (value) {
              _nro_asientos = value;
            },
          ),

          const SizedBox(height: 20,),
          TextField(
            decoration: const InputDecoration(hintText: 'numero de linea'),
            onChanged: (value) {
              _nro_linea = value;
            },
          ),

          const SizedBox(height: 20,),
          TextField(
            decoration: const InputDecoration(hintText: 'numero interno'),
            onChanged: (value) {
              _nroInterno = value;
            },
          ),

          const SizedBox(height: 20,),
          TextField(
            decoration: const InputDecoration(hintText: 'fecha de asignacion'),
            onChanged: (value) {
              _fecha_asignacion = value;
            },
          ),

          const SizedBox(height: 20,),
          TextField(
            decoration: const InputDecoration(hintText: 'fecha de baja'),
            onChanged: (value) {
              _fecha_baja = value;
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
      /*buildTextField("placa", "ejm: GX34J"),
      buildTextField("modelo", "ejm: suzuki"),
      buildTextField("numero de asientos", "ejm: 10"),
      buildTextField("numero de linea", "ejm: 52"),
      buildTextField("numero inteno", "ejm: A4567843"),
      buildTextField("fecha de asignacion", "ejm: año/mes/dia"),
      buildTextField("fecha de baja", "ejm: año/mes/dia"),
      const SizedBox(height: 0),*/

     /* Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(onPressed: (){},
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
            ),
            child: const Text("CANCEL", style: TextStyle(
                fontSize: 15,
                letterSpacing: 2,
                color: Colors.black
            )),
          ),
          ElevatedButton( onPressed: (){},
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
            ),
            child: const Text("SIGUIENTE", style: TextStyle(
                fontSize: 15,
                letterSpacing: 2,
                color: Colors.white
            )),
          )

        ],
      )*/
    ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder){
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
      ),
    );
  }

}
