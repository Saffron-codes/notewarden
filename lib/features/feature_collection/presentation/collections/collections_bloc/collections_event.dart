part of 'collections_bloc.dart';

@immutable
sealed class CollectionsEvent {}

class ToggleOrder extends CollectionsEvent {
  final CollectionOrder collectionOrder;
  ToggleOrder(this.collectionOrder);
}

class GetCollections extends CollectionsEvent {}

class AddCollection extends CollectionsEvent {
  final String name;
  AddCollection(this.name);
}

class DeleteCollection extends CollectionsEvent {
  final Collection collection;
  DeleteCollection(this.collection);
}
