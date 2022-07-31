import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea10.dart';

final Set<Polyline> linea10 = {
  Polyline(
    points: linea10I,
    polylineId: const PolylineId('Linea 10 (ida)'),
    width: 2,
    color: const Color.fromARGB(255, 29, 213, 173),
  ),
  Polyline(
    points: linea10V,
    polylineId: const PolylineId('Linea 10 (vuelta)'),
    width: 2,
    color: const Color.fromARGB(255, 236, 215, 55),
  ),
};
