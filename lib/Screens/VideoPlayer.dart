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

class ScreenShotIntent extends Intent{}
class PauseVideoIntent extends Intent{}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //int _counter = 0;
    Uint8List _imageFile;

    String fileName = "${DateTime.now().microsecondsSinceEpoch}${".png"}";
    String path = r'C:\Users\ACER\Desktop\hello';
    ScreenshotController sController = ScreenshotController();
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: Center(
        child: Shortcuts(shortcuts: {

          LogicalKeySet(LogicalKeyboardKey.backspace): ScreenShotIntent(),
          LogicalKeySet(LogicalKeyboardKey.space): PauseVideoIntent(),

        },

          child: Actions(
            actions: {
              PauseVideoIntent: CallbackAction<PauseVideoIntent>(onInvoke: (intent) => widget.player.playOrPause(),),
              ScreenShotIntent : CallbackAction<ScreenShotIntent>(onInvoke: (intent) {
                sController.captureAndSave(
                    path ,//set path where screenshot will be saved
                    fileName:fileName
                );
                print("ss taken");
                },


              )
            },

            child: Screenshot(
              controller: sController,
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.player.playOrPause();
                      },
                      child: Video(
                        player: widget.player,
                        scale: 1.0,
                        // default
                        showControls: false,
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
                          children:[ ElevatedButton(
                            onPressed: () {
                              widget.player.playOrPause();
                            },
                            child: const Text("play/pause"),
                          ),

                        ElevatedButton(
                          onPressed: () {
                            // //widget.player.playOrPause();
                            // sController.capture().then((Uint8List image) {
                            //   //Capture Done
                            //   setState(() {
                            //     _imageFile = image;
                            //   });
                            // }).catchError((onError) {
                            //   print(onError);
                            // });
                           // final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package


                            sController.captureAndSave(
                            path ,//set path where screenshot will be saved
                            fileName:fileName
                            );
                          },
                          child: const Text("Screenshot"),
                        ),
  ],)

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
