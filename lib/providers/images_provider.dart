import 'package:flutter/foundation.dart';

class ImagesProvider extends ChangeNotifier {
  String _imagePath = "";

  String get imagePath => _imagePath;

  void changeImagePath(String newPath){
    _imagePath = newPath;
    notifyListeners();
  }
}