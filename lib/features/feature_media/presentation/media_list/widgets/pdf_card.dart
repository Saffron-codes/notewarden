import 'package:flutter/material.dart';
import 'package:note_warden/features/feature_media/domain/model/media_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;

class PDFCard extends StatelessWidget {
  final Media pdfInfo;
  const PDFCard({super.key, required this.pdfInfo});

  Future<void> openExternally(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      print('Error sharing file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await openExternally(pdfInfo.location);
        // Navigator.pushNamed(context, "/media/pdf", arguments: pdfInfo);
        // context.pushNamed("pdf", extra: pdfInfo);
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
                path.basename(pdfInfo.location),
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
