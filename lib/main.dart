import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:outlet_location/provider/getJson.dart';
import 'package:provider/provider.dart';

import 'Screens/home.dart';

void main() {
  DartVLC.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>getJson())
  ], child: MyApp()), );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Home(),
    );
  }
}

