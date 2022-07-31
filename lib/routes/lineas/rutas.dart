import 'package:google_maps_controller/google_maps_controller.dart';

class Rutas {
  late final String name;
  Set<Polyline> polyline;

  Rutas(this.name, this.polyline);
}

class Ida {
  late String name;
  Polyline ini;
  Ida(this.name, this.ini);
}

class Vuelta {
  late String name;
  Polyline fin;
  Vuelta(this.name, this.fin);
}

class Lista {
  late LatLng ini;
}
