import 'package:note_warden/feature_media/domain/model/media_model.dart';
import 'package:note_warden/feature_media/domain/repository/media_repository.dart';

class GetMediaList {
  final MediaRepository mediaRepository;

  GetMediaList(this.mediaRepository);

  Future<List<Media>> invoke(int collectionId) async {
    return mediaRepository.getMediaList(collectionId);
  }
}
