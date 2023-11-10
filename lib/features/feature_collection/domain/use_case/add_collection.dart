import 'package:note_warden/features/feature_collection/domain/model/collection_model.dart';

import '../repository/collection_repository.dart';

class AddCollection {
  final CollectionRepository collectionRepository;
  const AddCollection(this.collectionRepository);

  Future<Collection> invoke(String name) async {
    return await collectionRepository.insertCollection(name);
  }
}
