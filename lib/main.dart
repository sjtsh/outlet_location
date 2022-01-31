import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:outlet_location/provider/getJson.dart';
import 'package:provider/provider.dart';

import 'ChooseFile/choose_file.dart';
import 'Screens/VideoPlayer.dart';

void main() {
  DartVLC.initialize();
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => getJson())],
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
      Media.file(File( r"C:\Users\Sajat\Desktop\26_04_2021_14_07_15_PROJOM00721.MP4")),
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: VideoPlayer(MediaJson(media: r"C:\Users\Sajat\Desktop\26_04_2021_14_07_15_PROJOM00721.MP4", json: r"C:\Users\ACER\Desktop\hello\04_20_2021 11_28_34.json"), player)
        // home: ChooseFile(),
    );
  }
}
