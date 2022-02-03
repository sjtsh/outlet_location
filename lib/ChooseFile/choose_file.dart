import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:outlet_location/New/VideoPlayer.dart';


class ChooseFile extends StatefulWidget {
  @override
  State<ChooseFile> createState() => _ChooseFileState();
}

class _ChooseFileState extends State<ChooseFile> {
  List<MediaJson> mediaJsons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RawMaterialButton(
                    onPressed: () async {
                      String? directoryPath = await FilePicker.platform
                          .getDirectoryPath(
                              dialogTitle: "Select the folder to rearrange");
                      if (directoryPath != null) {
                        List<File> videoFiles =
                            await FileManager(root: Directory(directoryPath))
                                .filesTree(
                          extensions: ["mp4", "MP4"],
                        );
                        for (File videoFile in videoFiles) {
                          String jsonFile = videoFile.path
                                  .substring(0, videoFile.path.length - 3) +
                              "json";
                          bool doesExist = await File(jsonFile).exists();
                          String? json;
                          if (!doesExist) {
                            jsonFile = videoFile.path
                                    .substring(0, videoFile.path.length - 3) +
                                "JSON";
                            doesExist = await File(jsonFile).exists();
                          }
                          if (doesExist) {
                            json = jsonFile;
                          }
                          mediaJsons.add(
                              MediaJson(json: json, media: videoFile.path));
                        }
                        setState(() {});
                      }
                    },
                    child: DottedBorder(
                      padding: EdgeInsets.all(12),
                      borderType: BorderType.RRect,
                      radius: Radius.circular(12),
                      color: Colors.red,
                      strokeWidth: 1,
                      dashPattern: [8, 6],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.upload_sharp,
                                  color: Colors.red,
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Folder With Json and Videos",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 60,
                  color: Colors.red.withOpacity(0.8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                            child: Text(
                          "Json Path",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.5),
                        width: 1,
                        height: double.infinity,
                      ),
                      Expanded(
                        child: Center(
                            child: Text(
                          "Media Path",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
                ...List.generate(
                  mediaJsons.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2,
                            offset: Offset(0, 2),
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Center(
                                        child: Text(mediaJsons[index].json ??
                                            "Not Found")),
                                  ),
                                ),
                                Container(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1,
                                  height: double.infinity,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Center(
                                        child: Text(mediaJsons[index].media)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                Player player = Player(id: 1);
                                player.open(
                                  Media.file(File(mediaJsons[index].media)),
                                );
                                return VideoPlayer(mediaJsons[index], player);
                              }));
                            },
                            child: Container(
                              color: Colors.green.withOpacity(0.1),
                              height: 50,
                              child: Center(child: Text("Start Working")),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
