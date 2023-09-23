import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:note_warden/feature_media/domain/model/media_model.dart';
import 'package:note_warden/feature_media/presentation/dialog/media_info_dialog.dart';
import 'package:open_file/open_file.dart';

class PDFPreview extends StatelessWidget {
  const PDFPreview({super.key});

  static const platform = MethodChannel('com.notewarden');

  Future<void> openExternally(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      print('Error sharing file: $e');
    }
  }

  Future<void> openFileInfo(BuildContext context, Media media) {
    return showDialog(
        context: context, builder: (context) => MediaInfoDialog(media: media));
  }

  @override
  Widget build(BuildContext context) {
    final pdfInfo = ModalRoute.of(context)!.settings.arguments as Media;
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfInfo.location.split('/').last),
        elevation: 1,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Open With",
                  child: const Text("Open With..."),
                  onTap: () async => openExternally(pdfInfo.location),
                ),
                const PopupMenuItem(
                  value: "File Info",
                  child: Text("File Info"),
                )
              ];
            },
            onSelected: (value) {
              if (value == "File Info") {
                openFileInfo(context, pdfInfo);
              }
            },
          )
        ],
      ),
      body: PDFView(
        filePath: pdfInfo.location,
      ),
    );
  }
}
