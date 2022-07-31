import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea01.dart';

final Set<Polyline> linea01 = {
  Polyline(
      points: linea01I,
      width: 2,
      polylineId: const PolylineId('Linea 1 (ida)'),
      color: const Color.fromARGB(255, 14, 75, 125)),
  Polyline(
      points: linea01V,
      width: 2,
      polylineId: const PolylineId('Linea 1 (vuelta)'),
      color: const Color.fromARGB(255, 108, 184, 245)),
};
