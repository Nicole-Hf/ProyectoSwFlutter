// ignore_for_file: use_build_context_synchronously, unnecessary_import

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/screens/perfil_page.dart';
import 'package:rutas_microbuses/services/conductor_service.dart';
import 'package:rutas_microbuses/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rutas_microbuses/variables.dart';
import 'package:intl/intl.dart';


class ConductorPage extends StatefulWidget {
  const ConductorPage({Key? key}) : super(key: key);

  @override
  State<ConductorPage> createState() => _ConductorPageState();
}

class _ConductorPageState extends State<ConductorPage> {
  final _dateController = TextEditingController();

  File ? pickedImage;
  String _fechanacimiento= '';
  String _ci= '';
  String _telefono= '';
  String _categorialic= '';
  String _foto = '';
  String _imagen64 = '';
  String _imagen = '';

  createDriverPressed() async {
    http.Response response = await ConductorService.createConductor(_fechanacimiento, _ci, _telefono, _categorialic, _foto);
    Map responseMap = jsonDecode(response.body);
    var dataConductor = json.decode(response.body);
    debugPrint('status: ${response.statusCode}');
    if (response.statusCode == 401) {
      idConductor = dataConductor['conductor']['id'];
      debugPrint('Conductor ID: $idConductor');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const PerfilPage(),)
      );
    } else {
      errorSnackBar(context, responseMap.values.first[0]);
    }
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      _imagen = photo.path;  
      List<int> bytes = File(_imagen).readAsBytesSync();
      _imagen64 = base64.encode(bytes);
      setState(() {
        pickedImage = tempImage;
        _foto = _imagen64;    
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
        centerTitle: true,
        title: const Text('Perfil de Conductor', 
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
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
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'El campo es requerido' : null,
                    keyboardType: TextInputType.datetime,
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Fecha de nacimiento",
                      icon: Icon(Icons.event),
                      hintText: "Seleccione una fecha",
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
                          debugPrint(_fechanacimiento);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'El campo es requerido' : null,
                    decoration: const InputDecoration(
                      labelText:'Carnet de Identidad',
                      icon: Icon(Icons.credit_card),
                      hintText: "Ej. 8456718j" 
                    ),
                    onChanged: (value) {
                      _ci = value;
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'El campo es requerido' : null,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Celular/Teléfono',
                      icon: Icon(Icons.call),
                      hintText: "Ingrese su número de celular"
                    ),
                    onChanged: (value) {
                      _telefono = value;
                    },
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'El campo es requerido' : null,
                    decoration: const InputDecoration(
                      labelText:'Categoría de Licencia',
                      icon: Icon(Icons.confirmation_num),
                      hintText:  "Ej. P, M, A, B, C, T"
                    ),
                    onChanged: (value) {
                      _categorialic = value;
                    },
                  ),
                  const SizedBox(height: 40,),
                  RoundedButton(
                    btnText: 'Completar registro',
                    onBtnPressed: () => createDriverPressed(),
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


