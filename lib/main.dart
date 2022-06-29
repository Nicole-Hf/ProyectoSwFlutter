import 'package:flutter/material.dart';
import 'package:rutas_microbuses/screens/loading.dart';

/*
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
      },
    );
  }
}
*/

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(     
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}

