// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rutas_microbuses/variables.dart';

class DrivingWidget extends StatefulWidget {
  const DrivingWidget({Key? key}) : super(key: key);

  @override
  _DrivingWidgetState createState() => _DrivingWidgetState();
}

class _DrivingWidgetState extends State<DrivingWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? _tipo;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [           
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 54, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Se inicio el recorrido de $tipo',
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: const Color.fromARGB(255, 50, 50, 50),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: IconButton(                     
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),  
                const SizedBox(height: 30,),           
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text('Fecha',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      Text(fecha,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text('Hora de salida',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      Text(horaSalida,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text('Hora de llegada estimada',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      Text(
                        horaSalida,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text('Tiempo estimado',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      Text(
                        horaSalida,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text('Distancia a recorrer',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      Text(
                        horaSalida,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ]
                  )
                ),
                SizedBox(
                  height: 330,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 50, 50, 50),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ChoiceChip(                    
                                            label: const Text('Ida',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.black, fontSize: 15)
                                            ),
                                            labelPadding: const EdgeInsets.symmetric(horizontal: 50),
                                            selected: _tipo == 'ida',
                                            onSelected: (bool selected) {
                                              setState(() {
                                                _tipo = selected ? 'ida' : null;
                                                debugPrint(_tipo);
                                              });
                                            },
                                            selectedColor: const Color.fromARGB(255, 111, 252, 106),
                                            shape: ContinuousRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0)
                                            )
                                          )
                                        ),
                                        Expanded(
                                          child: ChoiceChip(                    
                                            label: const Text('Vuelta',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.black, fontSize: 15)
                                            ),
                                              labelPadding: const EdgeInsets.symmetric(horizontal: 50),
                                            selected: _tipo == 'vuelta',
                                            onSelected: (bool selected) {
                                              setState(() {
                                                _tipo = selected ? 'vuelta' : null;
                                                debugPrint(_tipo);
                                              });
                                            },
                                            selectedColor: const Color.fromARGB(255, 111, 252, 106),
                                            shape: ContinuousRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0)
                                            )
                                          )
                                        ),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, -0.45),
                        child: IconButton(
                          color: const Color(0x8E000000),
                          onPressed: () {
                            
                          },
                          icon: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 50, 50, 50),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x8E000000),
                                  offset: Offset(0, 3),
                                )
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.power_settings_new_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
