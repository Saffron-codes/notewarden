import 'package:note_warden/features/feature_media/domain/repository/media_repository.dart';

class InsertMedia {
  final MediaRepository mediaRepository;

  InsertMedia(this.mediaRepository);

  Future<void> invoke(
    String collectionName,
    int collectionId,
    String filePath,
  ) async {
    return mediaRepository.insertMedia(collectionName, collectionId, filePath);
  }
}
