import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

class CaputuredImageScreen extends StatefulWidget {
  final Player player;
  final File file;

  CaputuredImageScreen(this.player, this.file);

  @override
  _CaputuredImageScreenState createState() => _CaputuredImageScreenState();
}



class _CaputuredImageScreenState extends State<CaputuredImageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Colors.black.withOpacity(0.1))
            ]),
            child: Expanded(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.player.play();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text("Captured Screen")
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.90,
                  child: widget.file != null
                      ? Image.file(widget.file)
                      : Container(),
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
                        decoration:
                            const InputDecoration(hintText: "Category"),
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
        ],
      ),
    );
  }
}