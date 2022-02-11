import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:outlet_location/provider/getJson.dart';
import 'package:outlet_location/provider/pausePlay.dart';
import 'package:provider/provider.dart';

import 'ChooseFile/ChooseFile.dart';
import 'ChooseFile/choose_file.dart';
import 'New/VideoPlayer.dart';

void main() {
  DartVLC.initialize();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => getJson()),
          ChangeNotifierProvider(create: (_)=> PausePlay())
        ],
        child: MyApp()),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Player player = Player(id: 1);
    player.open(
      Media.file(File(r"C:\Users\ACER\Desktop\test\L\04_20_2021 11_16_46\04_20_2021 11_16_46.MP4")),
    );
   // VideoPlayer(MediaJson(media:r"C:\Users\ACER\Desktop\test\L\04_20_2021 11_16_46\04_20_2021 11_16_46.MP4", json: "C:\Users\ACER\Desktop\test\L\04_20_2021 11_16_46\04_20_2021 11_16_46.json"), player);
    return MaterialApp(
        debugShowCheckedModeBanner: false,


        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:ChooseFolder(),
       // home: ChooseFile(),
       home:   VideoPlayer(MediaJson(media:r"C:\Users\ACER\Desktop\test\L\04_20_2021 11_16_46\04_20_2021 11_16_46.MP4", json: "C:\Users\ACER\Desktop\test\L\04_20_2021 11_16_46\04_20_2021 11_16_46.json"), player)
    );
  }
}
