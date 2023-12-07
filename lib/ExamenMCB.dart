 

import 'package:examenmcb/Home/EditarPost.dart';
import 'package:examenmcb/Home/Editarperfil.dart';
import 'package:examenmcb/Home/HomeView.dart';
import 'package:examenmcb/Home/MapaView.dart';
import 'package:examenmcb/Home/PostCreateView.dart';
import 'package:examenmcb/onBoarding/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:examenmcb/Splash/SplashView.dart';

import 'Singletone/DataHolder.dart';
import 'onBoarding/PerfilView.dart';
import 'onBoarding/RegisterView.dart';


class ExamenMCB extends StatelessWidget{

@override
Widget build(BuildContext context) {
  MaterialApp materialApp;
  DataHolder().initPlatformAdmin(context);
    materialApp=MaterialApp(title: "Examen",
      routes: {
        '/splashview':(context) => SplashView(),
        '/loginview':(context) => LoginView(),
        '/registerview':(context) => RegisterView(),
        '/perfilview':(context) => PerfilView(),
        '/homeview':(context) => HomeView(),
        '/postcreateview':(context) => PostCreateView(),
        '/editarpost':(context) => EditarPost(),
        '/mapaview':(context) => MapaView(),
        '/editarperfil':(context) => Editarperfil(),
      },
      initialRoute: '/splashview',
    );

  return materialApp;
}

}