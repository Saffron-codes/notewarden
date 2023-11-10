part of 'collections_bloc.dart';

@immutable
sealed class CollectionsState {}

class CollectionsLoaded extends CollectionsState {
  final List<Collection> collections;
  final CollectionOrder collectionOrder;
  CollectionsLoaded(this.collections, this.collectionOrder);
}

class CollectionsInitial extends CollectionsState {}

class CollectionsLoading extends CollectionsState {}
