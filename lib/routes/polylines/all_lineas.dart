import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea01.dart';
import 'package:rutas_microbuses/routes/points/linea02.dart';
import 'package:rutas_microbuses/routes/points/linea05.dart';
import 'package:rutas_microbuses/routes/points/linea08.dart';
import 'package:rutas_microbuses/routes/points/linea09.dart';
import 'package:rutas_microbuses/routes/points/linea10.dart';
import 'package:rutas_microbuses/routes/points/linea11.dart';
import 'package:rutas_microbuses/routes/points/linea16.dart';
import 'package:rutas_microbuses/routes/points/linea17.dart';
import 'package:rutas_microbuses/routes/points/linea18.dart';

final Set<Polyline> rutas = {
  Polyline(
    points: linea01I,
    polylineId: const PolylineId('L01I'),
    width: 2,
    color: const Color.fromARGB(255, 14, 75, 125),
  ),
  Polyline(
    points: linea01V,
    polylineId: const PolylineId('L01V'),
    width: 2,
    color: const Color.fromARGB(255, 108, 184, 245),
  ),
  Polyline(
    points: linea02I,
    polylineId: const PolylineId('L02I'),
    width: 2,
    color: const Color.fromARGB(255, 74, 176, 78),
  ),
  Polyline(
    points: linea02V,
    polylineId: const PolylineId('L02V'),
    width: 2,
    color: const Color.fromARGB(255, 49, 106, 51),
  ),
  Polyline(
    points: linea05I,
    polylineId: const PolylineId('L05I'),
    width: 2,
    color: const Color.fromARGB(255, 129, 35, 146),
  ),
  Polyline(
    points: linea05V,
    polylineId: const PolylineId('L05V'),
    width: 2,
    color: const Color.fromARGB(255, 227, 146, 25),
  ),
  Polyline(
    points: linea08I,
    polylineId: const PolylineId('L08I'),
    width: 2,
    color: const Color.fromARGB(255, 69, 196, 60),
  ),
  Polyline(
    points: linea08V,
    polylineId: const PolylineId('L08V'),
    width: 2,
    color: const Color.fromARGB(255, 164, 25, 234),
  ),
  Polyline(
    points: linea09I,
    polylineId: const PolylineId('L09I'),
    width: 2,
    color: const Color.fromARGB(255, 24, 121, 232),
  ),
  Polyline(
    points: linea09V,
    polylineId: const PolylineId('L09V'),
    width: 2,
    color: const Color.fromARGB(255, 119, 230, 15),
  ),
  Polyline(
    points: linea10I,
    polylineId: const PolylineId('L10I'),
    width: 2,
    color: const Color.fromARGB(255, 29, 213, 173),
  ),
  Polyline(
    points: linea10V,
    polylineId: const PolylineId('L10V'),
    width: 2,
    color: const Color.fromARGB(255, 236, 215, 55),
  ),
  Polyline(
    points: linea11I,
    polylineId: const PolylineId('L11I'),
    width: 2,
    color: const Color.fromARGB(255, 232, 139, 26),
  ),
  Polyline(
    points: linea11V,
    polylineId: const PolylineId('L11V'),
    width: 2,
    color: const Color.fromARGB(255, 211, 239, 33),
  ),
  Polyline(
    points: linea16I,
    polylineId: const PolylineId('L16I'),
    width: 2,
    color: const Color.fromARGB(255, 197, 67, 67),
  ),
  Polyline(
    points: linea16V,
    polylineId: const PolylineId('L16V'),
    width: 2,
    color: const Color.fromARGB(255, 214, 166, 11),
  ),
  Polyline(
    points: linea17I,
    polylineId: const PolylineId('L17I'),
    width: 2,
    color: const Color.fromARGB(255, 236, 74, 228),
  ),
  Polyline(
    points: linea17V,
    polylineId: const PolylineId('L17V'),
    width: 2,
    color: const Color.fromARGB(255, 110, 42, 199),
  ),
  Polyline(
    points: linea18I,
    polylineId: const PolylineId('L18I'),
    width: 2,
    color: const Color.fromARGB(255, 189, 21, 158),
  ),
  Polyline(
    points: linea18V,
    polylineId: const PolylineId('L18V'),
    width: 2,
    color: const Color.fromARGB(255, 42, 184, 210),
  ),
};
