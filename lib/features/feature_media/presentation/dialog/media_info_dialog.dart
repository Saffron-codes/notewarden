import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:note_warden/features/feature_media/domain/model/media_model.dart';

import '../../../../core/presentation/util/date_utils.dart';

class MediaInfoDialog extends StatelessWidget {
  final Media media;

  const MediaInfoDialog({super.key, required this.media});

  String getFileSize() {
    File file = File(media.location);
    int fileSizeInBytes = file.lengthSync();
    double fileSizeInKB = fileSizeInBytes / 1024;
    double fileSizeInMB = fileSizeInKB / 1024;
    double fileSizeInGB = fileSizeInMB / 1024;

    if (fileSizeInGB >= 1) {
      return '${fileSizeInGB.toStringAsFixed(2)} GB';
    } else if (fileSizeInMB >= 1) {
      return '${fileSizeInMB.toStringAsFixed(2)} MB';
    } else {
      return '${fileSizeInKB.toStringAsFixed(2)} KB';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Media Information'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Collection No: ${media.collectionId}'),
          const SizedBox(height: 8),
          Text('Created : ${formatDateTimeAgo(media.createdAt)}'),
          const SizedBox(height: 8),
          Text('File Size: ${getFileSize()}'),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
