import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_microbuses/routes/points/linea09.dart';
import 'package:rutas_microbuses/routes/points/linea10.dart';
import 'package:rutas_microbuses/routes/points/linea11.dart';
import 'package:rutas_microbuses/routes/points/linea16.dart';
import 'package:rutas_microbuses/routes/points/linea17.dart';
import 'package:rutas_microbuses/routes/points/linea18.dart';

final Set<Marker> markers = {
  //LINEA 01
  Marker(
    markerId: const MarkerId('L01IP'),
    position: const LatLng(-17.7863461268, -63.1086757239),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L01IL'),
    position: LatLng(-17.8542122803, -63.2041386088),
  ),
  Marker(
    markerId: const MarkerId('L01VP'),
    position: const LatLng(-17.8544822001, -63.2045056002),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L01VL'),
    position: LatLng(-17.7864831998, -63.1081744002),
  ),
  //LINEA 02
  Marker(
    markerId: const MarkerId('L02IP'),
    position: const LatLng(-17.8060659998,-63.1186616998),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L02IL'),
    position: LatLng(-17.8390140001,-63.2248933999),
  ),
  Marker(
    markerId: const MarkerId('L02VP'),
    position: const LatLng(-17.8384407996,-63.2239915),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L02VL'),
    position: LatLng(-17.8060659998,-63.1186616998),
  ),
  //LINEA 05
  Marker(
    markerId: const MarkerId('L05IP'),
    position: const LatLng(-17.7267533802, -63.1384822645),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L05IL'),
    position: LatLng(-17.8239472832, -63.2355585102),
  ),
  Marker(
    markerId: const MarkerId('L05VP'),
    position: const LatLng(-17.8251477167, -63.2347364167),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L05VL'),
    position: LatLng(-17.7267512865, -63.1384856451),
  ),
  //LINEA 08
  Marker(
    markerId: const MarkerId('L08IP'),
    position: const LatLng(-17.8260028997, -63.1337706999),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L08IL'),
    position: LatLng(-17.7181557, -63.1393337004),
  ),
  Marker(
    markerId: const MarkerId('L08VP'),
    position: const LatLng(-17.8280675001, -63.1372063998),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  const Marker(
    markerId: MarkerId('L08VL'),
    position: LatLng(-17.7180457002, -63.1386699004),
  ),
  //LINEA 09
  Marker(
    markerId: const MarkerId('L09IP'),
    position: linea09I.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L09IL'),
    position: linea09I.last,
  ),
  Marker(
    markerId: const MarkerId('L09VP'),
    position: linea09V.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L09VL'),
    position: linea09V.last,
  ),
  //LINEA 10
  Marker(
    markerId: const MarkerId('L10IP'),
    position: linea10I.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L10IL'),
    position: linea10I.last,
  ),
  Marker(
    markerId: const MarkerId('L10VP'),
    position: linea10V.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L10VL'),
    position: linea10V.last,
  ),
  //LINEA 11
  Marker(
    markerId: const MarkerId('L11IP'),
    position: linea11I.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L11IL'),
    position: linea11I.last,
  ),
  Marker(
    markerId: const MarkerId('L11VP'),
    position: linea11V.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L11VL'),
    position: linea11V.last,
  ),
  //LINEA 16
  Marker(
    markerId: const MarkerId('L16IP'),
    position: linea16I.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L16IL'),
    position: linea16I.last,
  ),
  Marker(
    markerId: const MarkerId('L16VP'),
    position: linea16V.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L16VL'),
    position: linea16V.last,
  ),
  //LINEA 17
  Marker(
    markerId: const MarkerId('L17IP'),
    position: linea17I.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L17IL'),
    position: linea17I.last,
  ),
  Marker(
    markerId: const MarkerId('L17VP'),
    position: linea17V.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L17VL'),
    position: linea17V.last,
  ),
  //LINEA 18
  Marker(
    markerId: const MarkerId('L18IP'),
    position: linea18I.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L18IL'),
    position: linea18I.last,
  ),
  Marker(
    markerId: const MarkerId('L18VP'),
    position: linea18V.first,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  ),
  Marker(
    markerId: const MarkerId('L18VL'),
    position: linea18V.last,
  ),
};