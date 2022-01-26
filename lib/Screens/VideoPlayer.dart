import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:outlet_location/Entity/MediaJson.dart';

class VideoPlayer extends StatefulWidget {
  MediaJson mediaJson;
  Player player;

  VideoPlayer(this.mediaJson, this.player);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: Center(
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
                  ElevatedButton(
                    onPressed: () {
                      widget.player.playOrPause();
                    },
                    child: const Text("play/pause"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
