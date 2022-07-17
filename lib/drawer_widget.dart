import 'package:flutter/material.dart';
import 'package:rutas_microbuses/screens/home_page.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20,),
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app_icon.png'),
                  fit: BoxFit.cover
                )
              ),
            )
          ),
          ListTile(
            title: const Text('Perfil',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            leading: const Icon(
              Icons.dashboard,
              size: 20.0,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage()
              ));
            },
          ),
          ListTile(
            title: const Text('Editar Perfil',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            leading: const Icon(
              Icons.edit,
              size: 20.0,
              color: Colors.grey,
            ),
            onTap: () {
              debugPrint('button clicked');
            },
          ), 
          ListTile(
            title: const Text('Iniciar recorrido',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            leading: const Icon(
              Icons.route,
              size: 20.0,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage()
              ));
            },
          ),                         
        ],
      ),
    );
  }
}