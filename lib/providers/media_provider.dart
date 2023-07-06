import 'package:flutter/foundation.dart';
import 'package:note_warden/models/media.dart';
import 'package:note_warden/services/media_service.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../models/collection_model.dart';
import '../utils/enums.dart';

class MediaProvider extends ChangeNotifier {
  List<Media> _media = [];

  final MediaService mediaService;

  MediaProvider({required this.mediaService});

  TaskState _addMediaState = TaskState.none;

  TaskState _loadMediaState = TaskState.none;

  TaskState _deleteMediaState = TaskState.none;

  TaskState get addMediaState => _addMediaState;

  TaskState get loadMediaState => _loadMediaState;

  TaskState get deleteMediaState => _deleteMediaState;

  List<Media> get media => _media;

  void addMedia(
      {required Collection collection,
      List<SharedMediaFile>? filePaths,
      List<String>? pathsfromPicker}) async {
    try {
      _addMediaState = TaskState.loading;
      notifyListeners();
      if (filePaths != null) {
        for (var mediaFile in filePaths) {
          await mediaService.saveMedia(
              collection: collection, filePath: mediaFile.path);
        }
      } else {
        for (var path in pathsfromPicker!) {
          await mediaService.saveMedia(collection: collection, filePath: path);
        }
      }

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
    _media = await mediaService.loadMedia(collectionId: collectionId);
    _loadMediaState = TaskState.success;
    // _addMediaState = TaskState.none;
    notifyListeners();
  }

  void resetMedia() async {
    _media = [];
    notifyListeners();
  }

  void deleteMedia(Media media,int index) async {
    _deleteMediaState = TaskState.loading;
    notifyListeners();
    try {
      await mediaService.deleteMedia(media: media);
      _media.removeAt(index);
      _deleteMediaState = TaskState.success;
      notifyListeners();
    } on Exception  {
      _deleteMediaState = TaskState.failure;
      notifyListeners();
    }
  }
}
