import 'package:note_warden/feature_collection/domain/model/collection_model.dart';

import '../repository/collection_repository.dart';

class SearchCollection {
  final CollectionRepository collectionRepository;

  const SearchCollection(this.collectionRepository);

  Future<List<Collection>> invoke(String name) async {
    return await collectionRepository.searchCollection(name);
  }
}
