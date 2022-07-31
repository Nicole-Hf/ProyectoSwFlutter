import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea08.dart';

final Set<Polyline> linea08 = {
  Polyline(
    polylineId: const PolylineId('Linea 8 (ida)'),
    width: 2,
    points: linea08I,
    color: const Color.fromARGB(255, 69, 196, 60)
  ),
  Polyline(
    points: linea08V,
    polylineId: const PolylineId('Linea 8 (vuelta)'),
    width: 2,
    color: const Color.fromARGB(255, 164, 25, 234)
  ),
};
