import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_warden/feature_media/domain/model/media_model.dart';
import 'package:note_warden/feature_media/domain/use_case/media_use_case.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaUseCase mediaUseCase;
  MediaBloc(this.mediaUseCase) : super(MediaInitial()) {
    on<AddMediaEvent>((event, emit) async {
      emit(MediaLoading());
      for (var media in event.filePaths) {
        await mediaUseCase.insertMedia
            .invoke(event.collectionName, event.collectionId, media);
      }
      add(GetMediaListEvent(event.collectionId));
    });

    on<GetMediaListEvent>((event, emit) async {
      emit(MediaLoading());
      final media = await mediaUseCase.getMediaList.invoke(event.collectionId);
      emit(MediaLoaded(media));
    });

    on<DeleteMediaEvent>((event, emit) async {
      emit(MediaLoading());
      await mediaUseCase.deleteMedia.invoke(event.media);
      add(GetMediaListEvent(event.media.collectionId));
    });
  }
}
