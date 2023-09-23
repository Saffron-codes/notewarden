part of 'collection_search_bloc.dart';

@immutable
sealed class CollectionSearchEvent {}

class SearchCollectionEvent extends CollectionSearchEvent {
  final String keyword;
  SearchCollectionEvent(this.keyword);
}
