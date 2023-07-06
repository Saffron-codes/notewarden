import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class MediaPreview extends StatelessWidget {
  final String path;
  const MediaPreview({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return path.endsWith(".pdf")
        ? PDFView(
            filePath: path,
          )
        : InteractiveViewer(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.file(File(path)),
              ),
            ),
          );
  }
}
