
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rutas_microbuses/services/linea_controller.dart';
import 'package:rutas_microbuses/models/linea.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/utils/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:rutas_microbuses/utils/variables.dart';
import 'package:intl/intl.dart';


class MicrobusPage extends StatefulWidget {
  const MicrobusPage({Key? key}) : super(key: key);

  @override
  State<MicrobusPage> createState() => _MicrobusPageState();
}

class _MicrobusPageState extends State<MicrobusPage> {
  final _dateController = TextEditingController();
  final _dateController1 = TextEditingController();
  File ? pickedImage;
  String _placa= '';
  String _modelo= '';
  String _nroasientos= '';
  String _nroInterno= '';
  String _fechaasignacion= '';
  String _fechabaja= '';
  String _foto = '';
  String _imagen = '';
  String _imagen64 = '';
  final _formKey = GlobalKey<FormState>();
  final _typeAheadController = TextEditingController();

  createAccountPressed() async {
    http.Response response = await AuthServices.microbusRegister(_placa,_modelo,_nroasientos,
        _nroInterno,_fechaasignacion,_fechabaja, _foto);
    Map responseMap = jsonDecode(response.body);
    http.Response responseBus = await LineaController.getBus();
    var dataBus = json.decode(responseBus.body);

    if (response.statusCode == 401) {
      interno = dataBus['nroInterno'];
      placa = dataBus['placa'];
      modelo = dataBus['modelo'];
      capacidad = dataBus['nro_asientos'];
      lineaName = dataBus['linea'];
      nombreConductor = dataBus['conductor'];
      //fotoMicro = dataBus['foto'];
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
      //encoding 64
      _imagen = photo.path;
      List<int> bytes = File(_imagen).readAsBytesSync();
      _imagen64 = base64.encode(bytes);
      setState(() {
        pickedImage = tempImage;
        //guardando en la bd
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
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    const SizedBox(
                      height: 10,
                    ),
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
                  TypeAheadFormField<Linea?>(
                    key: _formKey,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      decoration: const InputDecoration(
                        labelText: 'Seleccione una línea' ,
                        icon: Icon(Icons.bus_alert),
                      )
                    ),
                    suggestionsCallback: LineaController.getLineaSuggestion,
                    itemBuilder: (context, Linea? suggestion) {
                      final linea = suggestion!;
                      return ListTile(title: Text(linea.nombre),);
                    },
                    noItemsFoundBuilder: (context) => const SizedBox(
                        height: 100,
                        child: Text('No se encontró la línea', style: TextStyle(fontSize: 24),)
                    ),
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (Linea? suggestion) {
                      final linea = suggestion!;
                      _typeAheadController.text = suggestion.nombre;
                      setState(() {
                        idLinea = linea.id;
                      });
                      print('Linea id: $idLinea');
                    },
                    onSaved: (value) => idLinea = value as int,
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Placa',
                      icon: Icon(Icons.label_important),
                      hintText:"Ej. 1000BOL" 
                    ),
                    onChanged: (value) {
                      _placa = value;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Modelo (Opcional)' ,
                      icon: Icon(Icons.model_training),
                      hintText: "Ej. 2015"),
                    onChanged: (value) {
                      _modelo = value;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Capacidad (Opcional)',
                      icon: Icon(Icons.group),
                      hintText: "Ej. 20"),
                    onChanged: (value) {
                      _nroasientos = value;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Interno',
                      icon: Icon(Icons.numbers),
                      hintText: "Ej. 18"),
                    onChanged: (value) {
                      _nroInterno = value;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Fecha de asignacion (Opcional)",
                      icon: Icon(Icons.date_range),
                      hintText: "Fecha de asignacion",
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2024),
                        initialDate: DateTime.now(),
                        selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _dateController.text = DateFormat.yMd().format(selectedDate);
                          _fechaasignacion=  _dateController.text;
                          print(_fechaasignacion);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: _dateController1,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Fecha de baja (Opcional)",
                      icon: Icon(Icons.date_range_rounded),
                      hintText: "Fecha de baja",
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2024),
                        initialDate: DateTime.now(),
                        selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _dateController1.text = DateFormat.yMd().format(selectedDate);
                          _fechabaja=  _dateController1.text;
                          print(_fechabaja);
                        });
                      }
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
    );
  }
}