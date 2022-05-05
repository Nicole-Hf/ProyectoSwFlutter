import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeChoferPage extends StatefulWidget{
  const HomeChoferPage({Key? key}) : super(key: key);

  @override
  _HomeChoferPageState createState() => _HomeChoferPageState();
}

class _HomeChoferPageState extends State<HomeChoferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage Chofer'),
      ),
      body: const Text('home chofer'),
    );
  }
}