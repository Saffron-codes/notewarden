part of 'collection_search_bloc.dart';

@immutable
sealed class CollectionSearchState {}

final class CollectionSearchInitial extends CollectionSearchState {}

final class CollectionSearchLoading extends CollectionSearchState {}

final class CollectionSearchLoaded extends CollectionSearchState {
  final List<Collection> collections;
  CollectionSearchLoaded(this.collections);
}
