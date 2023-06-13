import 'package:flutter/foundation.dart';
import 'package:note_warden/models/media.dart';
import 'package:note_warden/services/media_service.dart';

import '../models/collection_model.dart';
import '../utils/enums.dart';

class MediaProvider extends ChangeNotifier {
  List<Media> _media = [];

  final MediaService mediaService;

  MediaProvider({required this.mediaService});

  TaskState _addMediaState = TaskState.none;

  TaskState _loadMediaState = TaskState.none;

  TaskState get addMediaState => _addMediaState;

  TaskState get loadMediaState => _loadMediaState;

  List<Media> get media => _media;

  void addMedia(
      {required Collection collection, required String filePath}) async {
    try {
      _addMediaState = TaskState.loading;
      notifyListeners();
      await mediaService.saveMedia(collection: collection, filePath: filePath);
      _addMediaState = TaskState.success;
      notifyListeners();
    } catch (e) {
      _addMediaState = TaskState.failure;
      notifyListeners();
    }
  }

  void loadMedia({required int collectionId}) async {
    _loadMediaState = TaskState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    _media = await mediaService.loadMedia(collectionId: collectionId);
    _loadMediaState = TaskState.success;
    // _addMediaState = TaskState.none;
    notifyListeners();
  }

  void resetMedia() async {
    _media = [];
    notifyListeners();
  }
}
