 

import 'package:examenmcb/Home/HomeView.dart';
import 'package:examenmcb/onBoarding/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:examenmcb/Splash/SplashView.dart';

import 'onBoarding/PerfilView.dart';
import 'onBoarding/RegisterView.dart';


class ExamenMCB extends StatelessWidget{

@override
Widget build(BuildContext context) {
  MaterialApp materialApp;

    materialApp=MaterialApp(title: "KyTy Miau!",
      routes: {
        '/splashview':(context) => SplashView(),
        '/loginview':(context) => LoginView(),
        '/registerview':(context) => RegisterView(),
        '/perfilview':(context) => PerfilView(),
        '/homeview':(context) => HomeView(),
      },
      initialRoute: '/loginview',
    );

  return materialApp;
}

}