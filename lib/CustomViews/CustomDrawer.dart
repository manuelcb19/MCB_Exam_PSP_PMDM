import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {


  Function(int indice)? onItemTap;
  String imagen;

  CustomDrawer({Key? key, required this.onItemTap, required this.imagen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imagen,
                  width: 100, // ajusta el ancho según tus necesidades
                  height: 100, // ajusta la altura según tus necesidades
                ),
                Text(
                  "Drawer Examen",
                  style: TextStyle(color: Colors.white,
                      fontSize: 20), // Añade un tamaño de fuente según tus necesidades
                ),
              ],
            ),
          ),
          ListTile(
            leading: Image.asset(
                'resources/imagenInicial.png', width: 50, height: 50),
            // Ajusta width y height según tus necesidades
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Perfil'),
            onTap: () {
              onItemTap!(1);
            },
          ),
          ListTile(
            leading: Image.asset(
                'resources/imagenInicial.png', width: 50, height: 50),
            // Ajusta width y height según tus necesidades
            title: const Text('Cerrar Sesion'),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            leading: Image.asset(
                'resources/imagenInicial.png', width: 50, height: 50),
            // Ajusta width y height según tus necesidades
            title: const Text('Consultar Temperatura'),
            onTap: () {
              onItemTap!(2);
            },

          ),
          ListTile(
            leading: Image.asset(
                'resources/imagenInicial.png', width: 50, height: 50),
            // Ajusta width y height según tus necesidades
            title: const Text('Consultar Mapa'),
            onTap: () {
              onItemTap!(3);
            },

          ),
        ],
      ),
    );
  }
}
