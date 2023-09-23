import 'package:note_warden/feature_collection/domain/repository/collection_repository.dart';
import 'package:note_warden/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/feature_collection/domain/model/collection_model.dart';

class GetCollections {
  final CollectionRepository collectionRepository;

  const GetCollections(this.collectionRepository);

  Future<List<Collection>> invoke(
      {CollectionOrder collectionOrder = CollectionOrder.byCreation}) async {
    return await collectionRepository.getCollections().then(
      (collections) {
        if (collectionOrder == CollectionOrder.byCreation) {
          collections.sort((a, b) => DateTime.now().compareTo(b.createdAt));
          return collections;
        } else {
          collections.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          return collections;
        }
      },
    );
  }
}
