import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:outlet_location/Components/colors.dart';
import 'package:outlet_location/Screens/VideoPlayer.dart';
import 'package:outlet_location/provider/getJson.dart';

import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Container(
                        height: height,
                        width: double.infinity,
                        color: AppColor.bgColor0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Builder(builder: (context) {
                                return Text(
                                    "${context.watch<getJson>().filename}");
                              }),
                              const SizedBox(
                                height: 12,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();

                                    if (result != null) {
                                      File file = File(
                                          result.files.single.path.toString());
                                      print(file);
                                      String filePath = file.toString();

                                      context
                                          .read<getJson>()
                                          .setFileName(filePath);
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  child: Container(
                                    child: const Text("Upload"),
                                  )),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text("Choose Video"),
                              const SizedBox(
                                height: 12,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    getVideoFile();
                                  },
                                  child: Container(
                                    child: const Text("Upload"),
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Container(
                        height: height,
                        width: double.infinity,
                        child: Builder(builder: (context) {
                          List<Media> medias = [];
                          Player player = Player(id: 1);
                          player.open(
                            Media.file(File(
                                r'C:\Users\ACER\Desktop\test\L\04_20_2021 11_03_20')),
                          );
                          return VideoPlayer(player);
                        }),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class MediaJson {
  final Media media;
  final String json;

  MediaJson(this.media, this.json);
}

getVideoFile() {}
