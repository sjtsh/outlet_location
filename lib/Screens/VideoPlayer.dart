import 'dart:io';
import 'dart:typed_data';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:screenshot/screenshot.dart';

class VideoPlayer extends StatefulWidget {
  final MediaJson mediaJson;
  final Player player;

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
                    ShowCapturedWidget(context, File(""), widget.player);
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
                    child: Container(
                      color: Colors.white,
                      child: Screenshot(
                        controller: sController,
                        child: Column(
                          children: [
                            Expanded(
                              child: Video(
                                player: widget.player,
                                scale: 1.0,
                                // default
                                showControls: false,
                              ),
                            ),
                            Container(
                              color: Colors.green,
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
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
                          ElevatedButton(
                            onPressed: () {
                              widget.player.playOrPause();
                            },
                            child: const Text("play/pause"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              File file =
                                  File(r"C:\Users\Sajat\Desktop\hello.png");
                              widget.player.pause();
                              widget.player.takeSnapshot(
                                  file,
                                  widget.player.videoDimensions.width,
                                  widget.player.videoDimensions.height);
                              sController
                                  .capture(delay: Duration(milliseconds: 10))
                                  .then((capturedImage) async {
                                if (capturedImage != null) {
                                  ShowCapturedWidget(
                                      context, file, widget.player);
                                } else {
                                  print("null value");
                                }
                              }).catchError((onError) {
                                print(onError);
                              });
                            },
                            child: const Text("Screenshot"),
                          ),
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
    BuildContext context, File file, Player player) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
                child: file != null
                    ? Image.file(file)
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
