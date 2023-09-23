import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_warden/feature_media/domain/model/media_model.dart';
import 'package:note_warden/feature_media/presentation/media_list/widgets/pdf_card.dart';

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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: media.length,
        itemBuilder: (context, index) {
          return media[index].location.endsWith(".pdf")
              ? PDFCard(
                  pdfInfo: media[index],
                )
              : GestureDetector(
                  //TODO:
                  onTap: () => Navigator.pushNamed(
                    context,
                    "/media/detailed",
                    arguments: {
                      "initialPage": index,
                      "collectionId": collectionId
                    },
                  ),
                  child: Container(
                    height: 200.0, // Fixed height for the card
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(
                          File(media[index].location),
                        ), // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
