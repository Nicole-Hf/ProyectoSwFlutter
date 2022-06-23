import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rutas_microbuses/pages/conductor_page.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/pages/login_page.dart';
import 'package:rutas_microbuses/pages/microbus_page.dart';
import 'package:rutas_microbuses/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Maps',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/conductor': (context) => const ConductorPage(),
        '/microbus': (context) => const MicrobusPage(),
        '/home': (context) => const HomePage(),
       // '/createbus': (context) => const BusPage(),
      },
    );
  }
}

