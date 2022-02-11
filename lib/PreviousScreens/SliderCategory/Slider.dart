import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_simple_sticker_view/flutter_simple_sticker_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:screenshot/screenshot.dart';

import '../../Database.dart';

class SliderCategory extends StatefulWidget {
  static final riKey1 = const Key('__RIKEY1__');
  final Function _changeIndicator;
  final File files;
  final int clusturIndex;
  final ScreenshotController screenshotController;

  SliderCategory(this._changeIndicator, this.files,
      this.clusturIndex, this.screenshotController);

  @override
  State<SliderCategory> createState() => _SliderCategoryState();
}

class _SliderCategoryState extends State<SliderCategory> {
  @override
  Widget build(BuildContext context) {
    GlobalKey _paintKey = new GlobalKey();
    Offset offsets = Offset(0,0);


    File sliderPersonalFiles = widget.files;

    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Screenshot(
            controller: widget.screenshotController,

            child: MouseRegion(
              onEnter:(event) {
                print("changed mouse cursor");
              } ,
              cursor:SystemMouseCursors.click ,


              child: Listener(
                onPointerDown: (event) {
                  print("Mouse clicked");
                  // RenderBox referenceBox = _paintKey.currentContext?.findRenderObject() as RenderBox;
                  // Offset offset = referenceBox.globalToLocal(event.position);
                double y = event.position.dy;
                 double x= event.position.dx;
                  Offset offset = Offset(x, y);

                  setState(() {
                    offsets = offset;
                    print(offsets);
                  });

                },
                child: CustomPaint(
                  key: _paintKey,
                  painter:MyCustomPainter(offsets) ,
                  child:
                    Image.file(
                      File(
                        sliderPersonalFiles.path,
                      ),
                      fit: BoxFit.contain,
                    ),
                    // [
                    //   Image.asset("icons/black.png"),
                    //   Image.asset("icons/blue.png"),
                    //   Image.asset("icons/green.png"),
                    //   Image.asset("icons/red.png"),
                    // ],
                    // stickerSize: 100,
                    // panelHeight: 70,
                    // panelBackgroundColor: Colors.transparent,
                    // panelStickerAspectRatio: 4,
                    // panelStickerBackgroundColor: Colors.transparent,
                  ),
                ),
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
                                widget.clusturIndex == e ? Colors.blue : Colors.black.withOpacity(0.5),
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
class MyCustomPainter extends CustomPainter {
  final Offset _offset;
  MyCustomPainter(this._offset);

  @override
  void paint(Canvas canvas, Size size) {
    if (_offset == null) return;
    canvas.drawCircle(_offset, 10.0, new Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(MyCustomPainter other) => other._offset != _offset;
}