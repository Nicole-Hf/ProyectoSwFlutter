import 'package:flutter/material.dart';
import 'package:rutas_microbuses/pages/bus_page.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/pages/login_page.dart';
import 'package:rutas_microbuses/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/createbus': (context) => const BusPage(),
      },
    );
  }
}

