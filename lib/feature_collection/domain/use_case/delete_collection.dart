import 'package:note_warden/feature_collection/domain/model/collection_model.dart';
import 'package:note_warden/feature_collection/domain/repository/collection_repository.dart';

class DeleteCollection {
  final CollectionRepository collectionRepository;
  const DeleteCollection(this.collectionRepository);

  Future<void> invoke(Collection collection) async {
    return collectionRepository.deleteCollection(collection);
  }
}
