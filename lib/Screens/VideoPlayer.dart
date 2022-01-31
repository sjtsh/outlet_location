import 'dart:io';
import 'dart:typed_data';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:outlet_location/provider/pausePlay.dart';
import 'package:provider/src/provider.dart';
import 'package:screenshot/screenshot.dart';

class VideoPlayer extends StatefulWidget {
  final MediaJson mediaJson;
  final Player player;

  VideoPlayer(this.mediaJson, this.player);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class ScreenShotIntent extends Intent {}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.player.play();
  }

  @override
  Widget build(BuildContext context) {
    //int _counter = 0;
    // Uint8List _imageFile;
    //
    // String fileName = "${DateTime.now().microsecondsSinceEpoch}${".png"}";
    // String path = r'C:\Users\ACER\Desktop\hello';
    ScreenshotController sController = ScreenshotController();
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: Center(
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.space): ScreenShotIntent(),
          },
          child: Actions(
            actions: {
              ScreenShotIntent: CallbackAction<ScreenShotIntent>(
                onInvoke: (intent) {
                  captureScreen(context, widget.player, sController);

                  print("ss taken");
                },
              )
            },
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<PausePlay>().playPauseVideo();
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
                              child: StreamBuilder<Object>(
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                context.read<PausePlay>().playPauseVideo();
                                widget.player.playOrPause();
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration:  BoxDecoration(

                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                 boxShadow: [
                                    BoxShadow(
                                    offset: Offset(0,2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.black.withOpacity(0.1))
                                ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    context.watch<PausePlay>().isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),

                            GestureDetector(
                              onTap: () {
                                captureScreen(
                                    context, widget.player, sController);
                              },
                              child: Container(

                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0,2),
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                          color: Colors.black.withOpacity(0.1))
                                    ]),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        )
                      ],
                    ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
           decoration: BoxDecoration(
             color: Colors.white,
               boxShadow: [
                 BoxShadow(
                     offset: Offset(0,2),
                     blurRadius: 2,
                     spreadRadius: 2,
                     color: Colors.black.withOpacity(0.1))
               ]
           ),
            child: Expanded(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        player.play();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text("Captured Screenshot")
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width * 0.70,
                     height: MediaQuery.of(context).size.height * 0.90,
                    child: file != null ? Image.file(file) : Container(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Number of outlets"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: "Category"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

captureScreen(
    context, Player player, ScreenshotController screenshotController) async {
  File file = await File(r"C:\Users\ACER\Desktop\hello\hellojk.jpeg");
  player.pause();
  player.takeSnapshot(
        file, player.videoDimensions.width, player.videoDimensions.height);
  // screenshotController
  //     .capture(delay: const Duration(milliseconds: 10))
  //     .then((capturedImage) async {
  //   if (capturedImage != null) {
  //     ShowCapturedWidget(context, file, player);
  //   } else {
  //     print("null value");
  //   }
  // }).catchError((onError) {
  //   print(onError);
  // });

  ShowCapturedWidget(context, file, player);
}


