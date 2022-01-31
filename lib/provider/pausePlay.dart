

import 'package:flutter/cupertino.dart';

class PausePlay with ChangeNotifier{
  bool _isPlaying = true;
  bool get isPlaying => _isPlaying;

  void playPauseVideo (){
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

}