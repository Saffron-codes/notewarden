import '../model/media_model.dart';

abstract class MediaRepository {
  Future<List<Media>> getMediaList(int collectionId);

  Future<void> insertMedia(
    String collectionName,
    int collectionId,
    String filePath,
  );

  Future<void> deleteMedia(Media media);
}
