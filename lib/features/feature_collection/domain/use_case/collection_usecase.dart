import 'package:note_warden/features/feature_collection/domain/use_case/add_collection.dart';
import 'package:note_warden/features/feature_collection/domain/use_case/delete_collection.dart';
import 'package:note_warden/features/feature_collection/domain/use_case/get_collections.dart';
import 'package:note_warden/features/feature_collection/domain/use_case/search_collection.dart';

class CollectionUseCase {
  final GetCollections getCollections;
  final AddCollection addCollection;
  final DeleteCollection deleteCollection;
  final SearchCollection searchCollection;

  const CollectionUseCase(
    this.getCollections,
    this.addCollection,
    this.deleteCollection,
    this.searchCollection,
  );
}
