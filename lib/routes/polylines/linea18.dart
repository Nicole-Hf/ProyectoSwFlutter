import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea18.dart';

final Set<Polyline> linea18 = {
  Polyline(
    points: linea18I,
    polylineId: const PolylineId('Linea 18 (ida)'),
    width: 2,
    color: const Color.fromARGB(255, 189, 21, 158),
  ),
  Polyline(
    points: linea18V,
    polylineId: const PolylineId('Linea 18 (vuelta)'),
    width: 2,
    color: const Color.fromARGB(255, 42, 184, 210),
  ),
};
