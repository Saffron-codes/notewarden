import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_warden/features/feature_collection/domain/model/collection_model.dart';
import 'package:note_warden/features/feature_collection/domain/use_case/collection_usecase.dart';
import 'package:note_warden/features/feature_collection/domain/util/collection_order.dart';

part 'collections_event.dart';
part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final CollectionUseCase collectionUseCase;
  CollectionsBloc(this.collectionUseCase) : super(CollectionsInitial()) {
    on<ToggleOrder>((event, emit) async {
      emit(CollectionsLoading());
      final collections = await collectionUseCase.getCollections
          .invoke(collectionOrder: event.collectionOrder);
      emit(CollectionsLoaded(collections, event.collectionOrder));
    });

    on<GetCollections>((event, emit) async {
      emit(CollectionsLoading());
      final collections = await collectionUseCase.getCollections.invoke();
      emit(CollectionsLoaded(collections, CollectionOrder.byCreation));
    });

    on<AddCollection>((event, emit) async {
      emit(CollectionsLoading());
      await collectionUseCase.addCollection.invoke(event.name);
      add(GetCollections());
    });

    on<DeleteCollection>((event, emit) async {
      emit(CollectionsLoading());
      await collectionUseCase.deleteCollection.invoke(event.collection);
      add(GetCollections());
    });
  }
}
