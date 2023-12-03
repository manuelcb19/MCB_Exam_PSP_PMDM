import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget{


  Function(int indice)? onItemTap;

  CustomDrawer({Key? key,required this.onItemTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(

              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'Navegable'
            ),
          ),
          ListTile(
            leading: Image.asset('resources/imageninicial.png'),
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Cerrar Sesion'),
            onTap: () {
              onItemTap!(0);

            },
          ),
          ListTile(
            leading: Image.asset('resources/imageninicial.png'),
            title: const Text('Ir al perfil'),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }

}
