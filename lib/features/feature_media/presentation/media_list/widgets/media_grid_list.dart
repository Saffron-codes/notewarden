import 'package:fluent_ui/fluent_ui.dart';
import 'package:note_warden/features/feature_media/domain/model/media_model.dart';
import 'package:note_warden/features/feature_media/presentation/media_list/widgets/media_preview_card.dart';

class MediaGridList extends StatelessWidget {
  final List<Media> media;
  final int collectionId;
  const MediaGridList(
      {super.key, required this.media, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 2,
        ),
        itemCount: media.length,
        itemBuilder: (context, index) {
          return MediaPreviewCard(media: media[index], index: index);
        },
      ),
    );
  }
}
