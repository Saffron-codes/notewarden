import 'package:flutter/foundation.dart';
import 'package:note_warden/services/collection_service.dart';
import 'package:note_warden/utils/enums.dart';

import '../models/collection_model.dart';

class CollectionProvider extends ChangeNotifier {
  List<Collection> _collections = [];

  final CollectionService collectionService;

  CollectionProvider({required this.collectionService});

  
  TaskState _addCollectionState = TaskState.none;

  TaskState _loadCollectionsState = TaskState.none;

  List<Collection> get collections => _collections;

  TaskState get addCollectionState => _addCollectionState;

  TaskState get loadCollectionsState => _loadCollectionsState;

  void addCollection({required String name}) async {
    try {
      _addCollectionState = TaskState.loading;
      notifyListeners();
      await collectionService.addCollection(name: name);
      _addCollectionState = TaskState.success;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 600));
      loadCollections();
    } catch (e) {
      _addCollectionState = TaskState.failure;
      notifyListeners();
    }
  }

  void loadCollections() async {
    _loadCollectionsState = TaskState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    _collections =  await collectionService.loadCollections();
    _loadCollectionsState = TaskState.success;
    _addCollectionState = TaskState.none;
    notifyListeners();
  }
}
