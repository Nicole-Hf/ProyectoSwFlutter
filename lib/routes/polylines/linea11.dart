import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../points/linea11.dart';

final Set<Polyline> linea11 = {
  Polyline(
    points: linea11I,
    polylineId: const PolylineId('Linea 11 (ida)'),
    width: 2,
    color: const Color.fromARGB(255, 232, 139, 26),
  ),
  Polyline(
    points: linea11V,
    polylineId: const PolylineId('Linea 11 (vuelta)'),
    width: 2,
    color: const Color.fromARGB(255, 211, 239, 33),
  ),
};
