import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_warden/feature_collection/domain/use_case/search_collection.dart';
import '../../../domain/model/collection_model.dart';

part 'collection_search_event.dart';
part 'collection_search_state.dart';

class CollectionSearchBloc
    extends Bloc<CollectionSearchEvent, CollectionSearchState> {
  final SearchCollection searchCollection;
  CollectionSearchBloc(this.searchCollection)
      : super(CollectionSearchInitial()) {
    on<SearchCollectionEvent>((event, emit) async {
      emit(CollectionSearchLoading());
      final collections = await searchCollection.invoke(event.keyword);
      emit(CollectionSearchLoaded(collections));
    });
  }
}
