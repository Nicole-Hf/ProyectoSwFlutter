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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade600,       
        elevation: 10,
        toolbarHeight: 70,
        title: const Text('App Chófer'),
        actions: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            /*decoration: BoxDecoration(
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(blurRadius: 7, spreadRadius: 3, color: Colors.grey)
              ],
              shape: BoxShape.circle,
              color: Colors.grey.shade600
            ),*/
            child: const Icon(Icons.logout, size: 20),
          ),
          const SizedBox(width: 26)
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[       
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              RaisedButton(
                elevation: 10.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                onPressed: () {

                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/bus_icon.jpg', height: 40.0, width: 40.0,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Iniciar Recorrido', 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                textColor: Colors.white,              
                color: Colors.orange.shade300,
                
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                  onPressed: () {

                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/ubt_icon.png', height: 40.0, width: 40.0,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Ir al Mapa', 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  textColor: Colors.white,              
                  color: Colors.orange.shade300,
                ),
              )  
            ],
          )
        ],
      )
    );
  }
}