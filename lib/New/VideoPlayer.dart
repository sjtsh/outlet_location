import 'dart:io';
import 'dart:typed_data';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outlet_location/Entity/MediaJson.dart';
import 'package:outlet_location/PreviousScreens/HomeScreen/HomeScreen.dart';
import 'package:outlet_location/provider/pausePlay.dart';
import 'package:provider/src/provider.dart';

import 'CapturedImageScreen.dart';

class VideoPlayer extends StatefulWidget {
  final MediaJson mediaJson;
  final Player player;

  VideoPlayer(this.mediaJson, this.player);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class ScreenShotIntent extends Intent {
  final Function capture;
  ScreenShotIntent(this.capture);

  void change() {
    capture();
  }
}

PositionState progress = PositionState();

class _VideoPlayerState extends State<VideoPlayer> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.player.play();
  }

  capture() {

    captureScreen(context, widget.player, _counter);
    _counter++;
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.space): ScreenShotIntent(capture),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): ScreenShotIntent(capture),
        LogicalKeySet(LogicalKeyboardKey.enter): ScreenShotIntent(capture),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): ScreenShotIntent(capture),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): ScreenShotIntent(capture),
      },
      child: Actions(
        actions: {
          ScreenShotIntent: CallbackAction(
            onInvoke: (intent) {
              ScreenShotIntent(capture).change();
            }
          ),
        },
        child: Scaffold(
          backgroundColor: const Color(0xfff4f4f4),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  rewindVideo(progress, widget.player);
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.fast_rewind,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<PausePlay>().playPauseVideo();
                  widget.player.playOrPause();
                },
                backgroundColor: Colors.white,
                child: Icon(
                  context.watch<PausePlay>().isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.black,
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
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Center(
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}

captureScreen(context, Player player, int index) async {
  File file = File("C:\\Users\\ACER\\Desktop\\hello\\$index.jpeg");
  player.takeSnapshot(
      file, player.videoDimensions.width, player.videoDimensions.height);

  player.pause();
  Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CaputuredImageScreen(player, file)));
}

rewindVideo(PositionState progress, Player player) {
  player.seek((progress.position)! - Duration(seconds: 15));
}
