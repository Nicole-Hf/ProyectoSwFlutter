import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea16.dart';

final Set<Polyline> linea16 = {
  Polyline(
    points: linea16I,
    polylineId: const PolylineId('Linea 16 (ida)'),
    width: 2,
    color: const Color.fromARGB(255, 197, 67, 67),
  ),
  Polyline(
    points: linea16V,
    polylineId: const PolylineId('Linea 16 (vuelta)'),
    width: 2,
    color: const Color.fromARGB(255, 214, 166, 11),
  ),
};
