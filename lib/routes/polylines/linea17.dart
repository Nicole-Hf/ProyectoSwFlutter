import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea17.dart';

final Set<Polyline> linea17 = {
  Polyline(
    points: linea17I,
    polylineId: const PolylineId('Linea 17 (ida)'),
    width: 2,
    color: const Color.fromARGB(255, 236, 74, 228),
  ),
  Polyline(
    points: linea17V,
    polylineId: const PolylineId('Linea 17 (vuelta)'),
    width: 2,
    color: const Color.fromARGB(255, 110, 42, 199),
  ),
};
