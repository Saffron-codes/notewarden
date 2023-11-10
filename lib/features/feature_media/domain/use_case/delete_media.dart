import 'package:note_warden/features/feature_media/domain/model/media_model.dart';
import 'package:note_warden/features/feature_media/domain/repository/media_repository.dart';

class DeleteMedia {
  final MediaRepository mediaRepository;

  DeleteMedia(this.mediaRepository);

  Future<void> invoke(Media media) async {
    return mediaRepository.deleteMedia(media);
  }
}
