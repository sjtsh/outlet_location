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
      backgroundColor: const Color(0xfff4f4f4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 100,
              color: Colors.black.withOpacity(0.3),
            ),

            //this is added in replacement for the padding
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) {
                          Player player = Player(id: 1);
                          player.open(
                            Media.file(File(mediaJsons[1].media)),
                          );
                          return VideoPlayer(mediaJsons[1], player);
                        }));

                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    "Add Folder",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
