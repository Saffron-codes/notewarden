part of 'media_bloc.dart';

@immutable
sealed class MediaEvent {}

class AddMediaEvent extends MediaEvent {
  final String collectionName;
  final int collectionId;
  final List<String> filePaths;

  AddMediaEvent(this.collectionName, this.collectionId, this.filePaths);
}

class GetMediaListEvent extends MediaEvent {
  final int collectionId;

  GetMediaListEvent(this.collectionId);
}

class DeleteMediaEvent extends MediaEvent {
  final Media media;

  DeleteMediaEvent(this.media);
}
