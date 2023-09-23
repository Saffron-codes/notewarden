import 'package:flutter/material.dart';
import 'package:note_warden/feature_media/domain/model/media_model.dart';

class PDFCard extends StatelessWidget {
  final Media pdfInfo;
  const PDFCard({super.key, required this.pdfInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, "/media/pdf", arguments: pdfInfo);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Center(
                child: Icon(
                  Icons.picture_as_pdf,
                  size: 48,
                  color: Colors.red,
                ),
              ),
              const Spacer(),
              Text(
                pdfInfo.location.split("/").last,
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
