
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:rutas_microbuses/services/auth_services.dart';
import 'package:rutas_microbuses/services/globals.dart';
import 'package:rutas_microbuses/utils/button.dart';
import 'package:image_picker/image_picker.dart';

import 'microbus_page.dart';

class conductorpage extends StatefulWidget {
  const conductorpage({Key? key}) : super(key: key);

  @override
  State<conductorpage> createState() => _conductorpageState();
}

class _conductorpageState extends State<conductorpage> {
  File ? pickedImage;

  String _name= '';
  String _fechanacimiento= '';
  String _ci= '';
  String _telefono= '';
  String _categorialic= '';

  createAccountPressed() async {
    http.Response response = await AuthServices.conductorRegister(_name, _fechanacimiento, _ci, _telefono, _categorialic);
    Map responseMap = jsonDecode(response.body);
    var dataUser = json.decode(response.body);
    if (response.statusCode == 401) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const MicrobusPage(),
          ));
    } else {
      // ignore: use_build_context_synchronously
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
                         //image: const DecorationImage(

                         //)
                       ),
                       child: ClipOval(
                         child: pickedImage !=null ? Image.file(pickedImage!,
                             width: 50,
                             height: 50,
                             fit:  BoxFit.cover):
                         Image.asset("assets/images/frozen.jpg",
                             width: 50,
                             height: 50,
                             fit:  BoxFit.cover
                         ),
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
                           child: IconButton(
                               onPressed: imagePickerOption,
                               icon: const Icon(

                             Icons.edit,
                             color: Colors.white,
                           ))
                          ,
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
                          RoundedButton(
                            btnText: 'Siguiente',
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


