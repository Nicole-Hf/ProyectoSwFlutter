import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea01.dart';

final Set<Polyline> rutasg = {
  Polyline(
      polylineId: const PolylineId('L01I'),
      points: linea01I,
      width: 2,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      color: const Color.fromARGB(255, 14, 75, 125)),
  Polyline(
    polylineId: const PolylineId('L01V'),
      points: linea01V,
      width: 2,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      color: const Color.fromARGB(255, 108, 184, 245)),
};