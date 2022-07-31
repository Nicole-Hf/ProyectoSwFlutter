import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea05.dart';

final Set<Polyline> linea05 = {
  Polyline(
    polylineId: const PolylineId('Linea 5 (ida)'),
    points: linea05I,
    width: 2,
    color: const Color.fromARGB(255, 129, 35, 146)
  ),
  Polyline(
    polylineId: const PolylineId('Linea 5 (vuelta)'),
    points: linea05V,
    width: 2,
    color: const Color.fromARGB(255, 227, 146, 25)
  ),
};
