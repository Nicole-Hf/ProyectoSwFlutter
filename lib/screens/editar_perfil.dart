import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rutas_microbuses/constant.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/models/conductor.dart';
import 'package:rutas_microbuses/screens/home_page.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/services/linea_controller.dart';
import 'package:rutas_microbuses/models/linea.dart';
import 'package:rutas_microbuses/services/conductor_service.dart';
import 'package:rutas_microbuses/button.dart';
import 'package:rutas_microbuses/services/user_service.dart';
import 'package:rutas_microbuses/variables.dart';
import 'package:intl/intl.dart';

class Editar_perfil extends StatefulWidget {
  const Editar_perfil({Key? key}) : super(key: key);

  @override
  State<Editar_perfil> createState() => _Editar_perfilState();
}

class _Editar_perfilState extends State<Editar_perfil> {
  Conductor? driver;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _dateController1 = TextEditingController();
  File? pickedImage;
  String nombre = '';
  String email = '';
  String password = '';
  String ci = '';
  String fecha_nacimiento = '';
  String telefono = '';
  String _foto = '';
  String _categoriaLic = '';
  String _imagen = '';
  String _imagen64 = '';
  final _formKey = GlobalKey<FormState>();
  final _typeAheadController = TextEditingController();

  /*createAccountPressed() async {
    http.Response response = await(
        nombre,
        email,
        password,
        ci,
        fecha_nacimiento,
        telefono,
        _foto);
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
      fotoMicro = dataBus['foto'];
      print('Foto Micro: $fotoMicro');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ));
    } else {
      errorSnackBar(context, responseMap.values.first[0]);
    }
  } */

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

  void getUser() async {
    ApiResponse response = await getConductorDetail();
    if (response.error == null) {
      setState(() {
        driver = response.data as Conductor;
        idConductor = driver!.id!;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
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
                padding:
                    const EdgeInsets.only(top: 10, right: 70.0, left: 70.0),
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
        /*leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),*/
        centerTitle: true,
        title: const Text(
          'Editar Perfil ',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
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
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRect(
                        child: pickedImage != null
                            ? Image.file(pickedImage!,
                                width: 50, height: 50, fit: BoxFit.cover)
                            : Image.network(imageUrl + '${driver!.telefono}'),
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
                              color: Colors.green),
                          child: IconButton(
                              onPressed: imagePickerOption,
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              )),
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'Nombre',
                        icon: Icon(Icons.label_important),
                        hintText: 'Carlos'),
                    onChanged: (value) {
                      nombre = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: 'email',
                        icon: Icon(Icons.model_training),
                        hintText: "@gmail.com"),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'password',
                        icon: Icon(Icons.group),
                        hintText: "********"),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'ci',
                        icon: Icon(Icons.numbers),
                        hintText: "12344677"),
                    onChanged: (value) {
                      ci = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Fecha de nacimiento",
                      icon: Icon(Icons.date_range),
                      hintText: "Fecha de nacimiento",
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2024),
                        initialDate: DateTime.now(),
                        selectableDayPredicate: (day) =>
                            day.isBefore(DateTime.now()),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _dateController.text =
                              DateFormat.yMd().format(selectedDate);
                          fecha_nacimiento = _dateController.text;
                          print(fecha_nacimiento);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _dateController1,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Fecha_nacimiento",
                      icon: Icon(Icons.date_range_rounded),
                      hintText: "Fecha de baja",
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2024),
                        initialDate: DateTime.now(),
                        selectableDayPredicate: (day) =>
                            day.isBefore(DateTime.now()),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _dateController1.text =
                              DateFormat.yMd().format(selectedDate);
                          telefono = _dateController1.text;
                          print(telefono);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundedButton(
                    btnText: 'Completar registro',
                    onBtnPressed: () {},
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
