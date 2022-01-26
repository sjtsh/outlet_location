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
      Media.file(File( r"D:\New folder\26_04_2021_13_31_53_PROJOM00718 - Copy (2).MP4")),
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: VideoPlayer(MediaJson(media: r"D:\New folder\26_04_2021_13_31_53_PROJOM00718 - Copy (2).MP4", json: r"D:\26_04_2021_13_31_53_PROJOM00718 - Copy (2).json"), player)
        // home: ChooseFile(),
    );
  }
}
