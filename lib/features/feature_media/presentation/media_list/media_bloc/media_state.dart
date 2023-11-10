part of 'media_bloc.dart';

@immutable
sealed class MediaState {}

final class MediaInitial extends MediaState {}

final class MediaLoading extends MediaState {}

final class MediaLoaded extends MediaState {
  final List<Media> media;
  MediaLoaded(this.media);
}
