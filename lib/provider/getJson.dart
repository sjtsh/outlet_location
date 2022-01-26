import 'package:flutter/cupertino.dart';

class getJson with ChangeNotifier{
 String _fileName = "Choose json file";
 String get filename => _fileName;

 void setFileName ( file){
   _fileName = file;
   notifyListeners();

 }
}