import 'package:examenmcb/ExamenMCB.dart';
import 'package:examenmcb/Singletone/DataHolder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DataHolder().initDataHolder();
  ExamenMCB examenmcb= ExamenMCB();
  runApp(examenmcb);


}
