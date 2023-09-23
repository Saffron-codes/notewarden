import 'package:note_warden/feature_media/domain/use_case/delete_media.dart';
import 'package:note_warden/feature_media/domain/use_case/get_media_list.dart';
import 'package:note_warden/feature_media/domain/use_case/insert_media.dart';

class MediaUseCase {
  final GetMediaList getMediaList;
  final InsertMedia insertMedia;
  final DeleteMedia deleteMedia;

  MediaUseCase(this.getMediaList, this.insertMedia, this.deleteMedia);
}
