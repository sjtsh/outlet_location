import 'dart:io';
import 'dart:typed_data';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:outlet_location/provider/pausePlay.dart';
import 'package:provider/src/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'CapturedImageScreen.dart';

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
    int _counter = 0;
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<PausePlay>().playPauseVideo();
              widget.player.playOrPause();
            },
            backgroundColor: Colors.white,
            child: Icon(
              context.watch<PausePlay>().isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,color: Colors.black,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          FloatingActionButton(
            onPressed: () {
              captureScreen(context, widget.player, _counter);
              _counter++;
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.camera_alt_outlined,color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.space): ScreenShotIntent(),
          },
          child: Actions(
            actions: {
              ScreenShotIntent: CallbackAction<ScreenShotIntent>(
                onInvoke: (intent) {
                  captureScreen(context, widget.player, _counter);
                  _counter++;

                  print("ss taken");
                },
              )
            },
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<PausePlay>().playPauseVideo();
                    widget.player.playOrPause();
                  },
                  child: Stack(
                    children: [
                      Video(
                        player: widget.player,
                        scale: 1.0,
                        // default
                        showControls: false,
                      ),
                      Positioned(
                        bottom: 80,
                        child: Container(
                          width: 1550,
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
                      ),
                    ],
                  ),
                ),
                // Container(
                //   height: 80,
                //   child: Padding(
                //     padding: const EdgeInsets.all(12.0),
                //     child: Row(
                //       children: [
                //         Expanded(child: Container()),
                //         GestureDetector(
                //           onTap: () {
                //             context.read<PausePlay>().playPauseVideo();
                //             widget.player.playOrPause();
                //           },
                //           child: Container(
                //             height: 50,
                //             width: 50,
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 shape: BoxShape.circle,
                //                 boxShadow: [
                //                   BoxShadow(
                //                       offset: Offset(0, 2),
                //                       blurRadius: 2,
                //                       spreadRadius: 2,
                //                       color: Colors.black.withOpacity(0.1))
                //                 ]),
                //             child: Padding(
                //               padding: EdgeInsets.all(4.0),
                //               child: Icon(
                //                 context.watch<PausePlay>().isPlaying
                //                     ? Icons.pause
                //                     : Icons.play_arrow,
                //               ),
                //             ),
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 12,
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             captureScreen(context, widget.player, _counter);
                //             _counter++;
                //           },
                //           child: Container(
                //             height: 50,
                //             width: 50,
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.circular(20),
                //                 boxShadow: [
                //                   BoxShadow(
                //                       offset: Offset(0, 2),
                //                       blurRadius: 2,
                //                       spreadRadius: 2,
                //                       color: Colors.black.withOpacity(0.1))
                //                 ]),
                //             child: const Padding(
                //               padding: EdgeInsets.all(8.0),
                //               child: Icon(
                //                 Icons.camera_alt_outlined,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(child: Container()),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

captureScreen(context, Player player, int index) async {
  File file = File("C:\\Users\\Dell\\Desktop\\Moviess\\$index.jpeg");

  player.pause();
  player.takeSnapshot(
      file, player.videoDimensions.width, player.videoDimensions.height);
  Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CaputuredImageScreen(player, file)));
}
