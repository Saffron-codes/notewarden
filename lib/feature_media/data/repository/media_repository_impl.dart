import 'package:note_warden/feature_media/data/data_source/media_data_source.dart';
import 'package:note_warden/feature_media/domain/model/media_model.dart';
import 'package:note_warden/feature_media/domain/repository/media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaDataSource mediaDataSource;

  const MediaRepositoryImpl(this.mediaDataSource);

  @override
  Future<void> deleteMedia(Media media) async {
    return mediaDataSource.deleteMedia(media);
  }

  @override
  Future<List<Media>> getMediaList(int collectionId) async {
    return mediaDataSource.getMediaList(collectionId);
  }

  @override
  Future<void> insertMedia(
      String collectionName, int collectionId, String filePath) async {
    return await mediaDataSource.saveMedia(
      collectionName,
      collectionId,
      filePath,
    );
  }
}
