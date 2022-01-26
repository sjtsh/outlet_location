import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final player;
  VideoPlayer(this.player);
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
    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Video(
                    player: widget.player,
                    height: 600,
                    width: double.infinity,
                    scale: 1.0,
                    // default
                    showControls: true,
                  ),
                ),
              ],
            ),
            StreamBuilder<Object>(
              stream: widget.player.positionStream,
              initialData: PositionState(),
              builder: (context, AsyncSnapshot snapshot) {
                  PositionState progress = snapshot.data;
                  return Builder(
                    builder: (context) {
                      return Center(
                        child: Text(
                              (progress.position).toString().substring(3, 7),
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                  );

              },
            ),
            ElevatedButton(
                onPressed: () {
                  widget.player.playOrPause();
                },
                child: Text("play/pause"))
          ],
        ),
      ),
    );
  }
}
