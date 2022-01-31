import 'dart:io';
import 'dart:typed_data';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:screenshot/screenshot.dart';

class VideoPlayer extends StatefulWidget {
  MediaJson mediaJson;
  Player player;

  VideoPlayer(this.mediaJson, this.player);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class ScreenShotIntent extends Intent {}

class PauseVideoIntent extends Intent {}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //int _counter = 0;
    // Uint8List _imageFile;

    String fileName = "${DateTime.now().microsecondsSinceEpoch}${".png"}";
    String path = r'C:\Users\ACER\Desktop\hello';
    ScreenshotController sController = ScreenshotController();
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: Center(
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.backspace): ScreenShotIntent(),
            LogicalKeySet(LogicalKeyboardKey.space): PauseVideoIntent(),
          },
          child: Actions(
            actions: {
              PauseVideoIntent: CallbackAction<PauseVideoIntent>(
                onInvoke: (intent) => widget.player.playOrPause(),
              ),
              ScreenShotIntent: CallbackAction<ScreenShotIntent>(
                onInvoke: (intent) {
                  sController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    ShowCapturedWidget(context, capturedImage!, widget.player);
                  }).catchError((onError) {
                    print(onError);
                  });

                  print("ss taken");
                },
              )
            },
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.player.playOrPause();
                    },
                    child: Screenshot(
                      controller: sController,
                      child: Container(
                        color: Colors.white,
                        child: Video(
                          player: widget.player,
                          scale: 1.0,
                          // default
                          showControls: false,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  child: Column(
                    children: [
                      StreamBuilder<Object>(
                        stream: widget.player.positionStream,
                        initialData: PositionState(),
                        builder: (context, AsyncSnapshot snapshot) {
                          PositionState progress = snapshot.data;
                          return Builder(builder: (context) {
                            return Slider(
                              value: progress.position!.inSeconds + 0.0,
                              onChanged: (double value) {},
                              max: progress.duration!.inSeconds + 0.0,
                            );
                            // return Center(
                            //   child: Text(
                            //     (progress.position).toString().substring(3, 7) +
                            //         "/" +
                            //         (progress.duration).toString().substring(3, 7),
                            //     style: const TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 50,
                            //     ),
                            //   ),
                            // );
                          });
                        },
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffcecece),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.pause,
                                size: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              widget.player.playOrPause();
                            },
                            child: const Text("play/pause"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              widget.player.pause();
                              sController
                                  .capture(delay: Duration(milliseconds: 10))
                                  .then((capturedImage) async {
                                ShowCapturedWidget(
                                    context, capturedImage!, widget.player);
                              }).catchError((onError) {
                                print(onError);
                              });
                            },
                            child: const Text("Screenshot"),
                          ),
                          Expanded(child: Container()),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> ShowCapturedWidget(
    BuildContext context, Uint8List capturedImage, Player player) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        player.play();
                      },
                      icon: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Captured Screenshot")
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
                child: capturedImage != null
                    ? Image.memory(capturedImage)
                    : Container()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              player.play();
            },
            child: const Text("Back"),
          ),
        ],
      ),
    ),
  );
}

// _saved(File image) async {
//   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
//   print("File Saved to Gallery");
// }
