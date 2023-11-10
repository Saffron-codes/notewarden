import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:note_warden/features/feature_media/domain/model/media_model.dart';
import 'package:note_warden/features/feature_media/presentation/media_detailed/media_detailed_view.dart';

import 'pdf_card.dart';

class MediaPreviewCard extends StatefulWidget {
  final Media media;
  final int index;
  const MediaPreviewCard({super.key, required this.media, required this.index});

  @override
  State<MediaPreviewCard> createState() => _MediaPreviewCardState();
}

class _MediaPreviewCardState extends State<MediaPreviewCard> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: widget.media.location.endsWith(".pdf")
          ? PDFCard(
              pdfInfo: widget.media,
            )
          : GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  FluentPageRoute(
                    builder: (context) => MediaDetailedView(
                      initialPage: widget.index,
                      collectionId: widget.media.collectionId,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: "image-${widget.index}",
                child: Container(
                  height: 100.0, // Fixed height for the card
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(widget.media.location),
                      ), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
    );
  }
}
