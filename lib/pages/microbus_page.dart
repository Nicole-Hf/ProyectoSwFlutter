// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';

class MicrobusPage extends StatefulWidget {
  const MicrobusPage({Key? key}) : super(key: key);

  @override
  State<MicrobusPage> createState() => _MicrobusPageState();
}

class _MicrobusPageState extends State<MicrobusPage> {
  File ? pickedImage;
  String _placa= '';
  String _modelo= '';
  String _nroasientos= '';
  String _nrolinea= '';
  String _nroInterno= '';
  String _fechaasignacion= '';
  String _fechabaja= '';

  createAccountPressed() async {
    http.Response response = await AuthServices.microbusRegister(_placa,_modelo,_nroasientos,_nrolinea,
        _nroInterno,_fechaasignacion,_fechabaja);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 401) {
      print("datos registrados");
      Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const HomePage(),
          ));
    } else {
      errorSnackBar(context, responseMap.values.first[0]);
    }
  }
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      print(tempImage);
      setState(() {
        pickedImage = tempImage;
      });
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    void imagePickerOption() {
      Get.bottomSheet(
        SingleChildScrollView(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Container(
              color: Colors.white,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Pic Image From",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("CAMERA"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("GALLERY"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text("CANCEL"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1,
      leading: InkWell(
        onTap: () async {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
          size: 24,
        ),
      ),
      title: const Text('Añadir Microbus', style: TextStyle(fontSize: 20, color: Colors.black),),
    ),
    body: Container(
      padding: const EdgeInsets.only(left: 16,top: 25,right: 16),
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
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
                    ),
                    child: ClipRect(
                      child: pickedImage != null 
                        ? Image.file(pickedImage!, width: 50, height: 50, fit:  BoxFit.cover)
                        : Image.asset("assets/images/bus_icon.jpg", width: 50, height: 50, fit:  BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: Colors.white),
                        color: Colors.green
                      ),
                      child: IconButton(
                        onPressed: imagePickerOption,
                        icon: const Icon(Icons.camera_alt,color: Colors.white,)
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
                  decoration: const InputDecoration(hintText: 'Placa'),
                  onChanged: (value) {
                    _placa = value;
                  },
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(hintText: 'Modelo'),
                  onChanged: (value) {
                    _modelo = value;
                  },
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(hintText: 'Capacidad'),
                  onChanged: (value) {
                    _nroasientos = value;
                  },
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(hintText: 'Número de linea'),
                  onChanged: (value) {
                    _nrolinea = value;
                  },
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(hintText: 'Interno'),
                  onChanged: (value) {
                    _nroInterno = value;
                  },
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(hintText: 'Fecha de asignación'),
                  onChanged: (value) {
                    _fechaasignacion = value;
                  },
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(hintText: 'Fecha de baja'),
                  onChanged: (value) {
                    _fechabaja = value;
                  },  
                ),
                const SizedBox(height: 40,),
                RoundedButton(
                  btnText: 'Completar registro',
                  onBtnPressed: () => createAccountPressed(),
                ),
                const SizedBox(height: 40,)
              ],
            ),
          ],
        ),
      ),
    ),
  );}
}
