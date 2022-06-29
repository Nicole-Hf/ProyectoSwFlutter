// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rutas_microbuses/models/api_response.dart';
import 'package:rutas_microbuses/pages/home_page.dart';
import 'package:rutas_microbuses/screens/login.dart';
import 'package:rutas_microbuses/services/user_service.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (route) => false);
    } else {
      ApiResponse response = await getUser();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}