import 'package:flutter/foundation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class SharedMediaProvider extends ChangeNotifier {
  String _imagePath = "";
  List<SharedMediaFile> _mediaFiles = [];

  String get imagePath => _imagePath;
  List<SharedMediaFile> get mediaFiles => _mediaFiles;

  void changeImagePath(String newPath){
    _imagePath = newPath;
    notifyListeners();
  }

  void addFiles(List<SharedMediaFile> files){
    _mediaFiles = files;
    notifyListeners();
  }
}