import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_simple_sticker_view/flutter_simple_sticker_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:screenshot/screenshot.dart';

import '../../Database.dart';

class SliderCategory extends StatelessWidget {
  static final riKey1 = const Key('__RIKEY1__');
  final Function _changeIndicator;
  final File files;
  final int clusturIndex;
  final ScreenshotController screenshotController;

  SliderCategory(this._changeIndicator, this.files,
      this.clusturIndex, this.screenshotController);

  @override
  Widget build(BuildContext context) {


    File sliderPersonalFiles = files;

    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Screenshot(
            controller: screenshotController,

            child: FlutterSimpleStickerView(
              Image.file(
                File(
                  sliderPersonalFiles.path,
                ),
                fit: BoxFit.contain,
              ),
              [
                Image.asset("icons/black.png"),
                Image.asset("icons/blue.png"),
                Image.asset("icons/green.png"),
                Image.asset("icons/red.png"),
              ],
              stickerSize: 100,
              panelHeight: 70,
              panelBackgroundColor: Colors.transparent,
              panelStickerAspectRatio: 4,
              panelStickerBackgroundColor: Colors.transparent,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(clusturCount, (index) => index)
                  .map(
                    (e) => Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color:
                                clusturIndex == e ? Colors.blue : Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
