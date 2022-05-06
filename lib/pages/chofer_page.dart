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
      body: Stack(
        children: <Widget>[
          Column(
            children: const <Widget>[
              SizedBox(height: 70.0,),
              SizedBox(
                height: 0.0,
                child: Text(
                  "Bienvenido", 
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 28.0, 
                    fontWeight: FontWeight.bold
                  )
                )
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/bus_icon.jpg', height: 40.0, width: 40.0,),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Registrar Microbus', 
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                textColor: const Color(0xFFFFC107),
                color: const Color(0xFFDADADA),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/ubt_icon.png', height: 40.0, width: 40.0,),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Registrar Microbus', 
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  textColor: const Color(0xFFFFC107),
                  color: const Color(0xFFDADADA),
                ),
              )  
            ],
          )
        ],
      )
    );
  }
}