import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:outlet_location/provider/getJson.dart';
import 'package:outlet_location/provider/pausePlay.dart';
import 'package:provider/provider.dart';

import 'ChooseFile/ChooseFile.dart';
import 'ChooseFile/choose_file.dart';
import 'Screens/VideoPlayer.dart';

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
      Media.file(File( r"C:\Users\Dell\Desktop\Moviess\NeverthelessE06.MP4")),
    );
    //VideoPlayer(MediaJson(media: r"C:\Users\Dell\Desktop\Moviess\22d_1625761945.22.9_265142.MP4", json: r"C:\Users\Dell\Desktop\Moviess\22d_1625761945.22.9_265142.json"), player)
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:ChooseFolder(),
        // home: ChooseFile(),
      home: VideoPlayer(MediaJson(media: r"C:\Users\Dell\Desktop\Moviess\NeverthelessE06.MP4", json: r"C:\Users\Dell\Desktop\Moviess\NeverthelessE06.json"), player),
    );
  }
}
