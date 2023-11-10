import 'package:note_warden/features/feature_collection/domain/model/collection_model.dart';

abstract class CollectionRepository {
  Future<List<Collection>> getCollections();

  Future<Collection> insertCollection(String name);

  Future<void> deleteCollection(Collection collection);

  Future<List<Collection>> searchCollection(String name);
}
