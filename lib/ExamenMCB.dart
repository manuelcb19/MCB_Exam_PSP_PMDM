

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:examenmcb/Splash/SplashView.dart';


class ExamenMCB extends StatelessWidget{

@override
Widget build(BuildContext context) {
  MaterialApp materialApp;

    materialApp=MaterialApp(title: "KyTy Miau!",
      routes: {
        '/splashview':(context) => SplashView(),
      },
      initialRoute: '/splashview',
    );

  return materialApp;
}

}