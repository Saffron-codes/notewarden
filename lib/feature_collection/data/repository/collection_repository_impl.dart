import 'package:note_warden/feature_collection/data/data_source/collection_datasource.dart';
import 'package:note_warden/feature_collection/domain/model/collection_model.dart';

import '../../domain/repository/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionDataSource collectionDataSource;

  const CollectionRepositoryImpl(this.collectionDataSource);

  @override
  Future<void> deleteCollection(Collection collection) async {
    return collectionDataSource.deleteCollection(collection);
  }

  @override
  Future<List<Collection>> getCollections() {
    return collectionDataSource.getCollections();
  }

  @override
  Future<Collection> insertCollection(String name) {
    return collectionDataSource.insertCollection(name);
  }

  @override
  Future<List<Collection>> searchCollection(String name) {
    return collectionDataSource.searchCollection(name);
  }
}
