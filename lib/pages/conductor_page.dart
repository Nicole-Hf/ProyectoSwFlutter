// ignore_for_file: unnecessary_import, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/utils/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rutas_microbuses/utils/variables.dart';
import 'microbus_page.dart';
import 'package:intl/intl.dart';


class ConductorPage extends StatefulWidget {
  const ConductorPage({Key? key}) : super(key: key);

  @override
  State<ConductorPage> createState() => _ConductorPageState();
}

class _ConductorPageState extends State<ConductorPage> {
  final _dateController = TextEditingController();

  File ? pickedImage;
  String _name= '';
  String _fechanacimiento= '';
  String _ci= '';
  String _telefono= '';
  String _categorialic= '';
  String _foto = '';

  createAccountPressed() async {
    http.Response response = await AuthServices.conductorRegister(_name, _fechanacimiento, _ci, _telefono, _categorialic, _foto);
    Map responseMap = jsonDecode(response.body);
    var dataConductor = json.decode(response.body);
    if (response.statusCode == 401) {
      idConductor = dataConductor['conductor']['id'];
      nombreConductor = dataConductor['conductor']['nombre'];
      Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const MicrobusPage(),
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
        //probando guardar la ruta de la imagen
        _foto = tempImage.toString();
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
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 10 ,right: 70.0, left: 70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("Cámara"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("Galería"),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text("Cancelar"),
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
        title: const Text('Perfil', style: TextStyle(fontSize: 20, color: Colors.black),),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
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
                      ),
                      child: ClipOval(
                        child: pickedImage !=null 
                          ? Image.file(pickedImage!,width: 50, height: 50, fit:  BoxFit.cover)
                          : Image.asset("assets/images/user_icon.png", width: 50, height: 50, fit:  BoxFit.cover),
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
                          border: Border.all(width: 4, color: Colors.white)                        ,
                          color: Colors.green
                        ),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: imagePickerOption,
                          icon: const Icon(Icons.edit, color: Colors.white,),
                          alignment: Alignment.center,
                        ),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  const SizedBox(height: 25,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                      icon: Icon(Icons.person),
                      hintText: "ejm: yimmi neutron"
                    ),
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                  const SizedBox(height: 25,),
                  // display the selected date
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Fecha de Nacimiento",
                      icon: Icon(Icons.event),
                      hintText: "Fecha de Nacimiento",
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2024),
                        initialDate: DateTime.now(),
                        selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _dateController.text = DateFormat.yMd().format(selectedDate);
                          _fechanacimiento=  _dateController.text;
                          print(_fechanacimiento);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText:'Carnet de Identidad',
                      icon: Icon(Icons.credit_card),
                      hintText: "ejm: 11338034" 
                    ),
                    onChanged: (value) {
                      _ci = value;
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Celular/Teléfono',
                      icon: Icon(Icons.call),
                      hintText: "celular"
                    ),
                    onChanged: (value) {
                      _telefono = value;
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText:'Categoría de Licencia',
                      icon: Icon(Icons.confirmation_num),
                      hintText:  "ejm: A"
                    ),
                    onChanged: (value) {
                      _categorialic = value;
                    },
                  ),
                  const SizedBox(height: 40,),
                  RoundedButton(
                    btnText: 'Continuar',
                    onBtnPressed: () => createAccountPressed(),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


