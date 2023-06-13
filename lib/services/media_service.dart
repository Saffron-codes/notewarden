import 'dart:io';
import 'package:note_warden/models/collection_model.dart';
import 'package:note_warden/models/media.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';

class MediaService {
  final Database db;
  Logger logger = Logger();

  MediaService(this.db);

  Future<List<Media>> loadMedia({required int collectionId}) async {
    final rawMedia = await db
        .query("Media", where: "collectionId = ?", whereArgs: [collectionId]);
    return List<Media>.from(
        rawMedia.map((model) => Media.fromJson(model)));
  }

  Future<void> saveMedia(
      {required Collection collection, required String filePath}) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      Directory? externalDirectory = await getExternalStorageDirectory();

      if (externalDirectory != null) {
        // Create a subdirectory within the external directory (optional)
        Directory subDirectory = Directory(
            '${externalDirectory.path}/NoteWarden/${collection.name}');
        if (!await subDirectory.exists()) {
          await subDirectory.create(recursive: true);
        }

        // Get the file name from the image path
        String fileName = filePath.split('/').last;

        // Create the destination file path in the external directory
        String destinationPath = '${subDirectory.path}/$fileName';

        // Copy the image file to the destination path
        await File(filePath).copy(destinationPath);

        // Optional: Verify if the image file exists in the external directory
        File copiedImageFile = File(destinationPath);
        if (await copiedImageFile.exists()) {
          // print('Image saved to external directory successfully!');
          try {
            await insertMedia(
                location: destinationPath, collectionId: collection.id);
            logger.i("Media DB Done");
          } catch (e) {
            logger.e("Media DB Error");
            throw Exception('Media DB Error');
          }

          return;
        } else {
          throw Exception('Failed to save the image to external directory.');
        }
      } else {
        throw Exception('External storage directory not available.');
      }
    } else {
      openAppSettings();
      return;
    }
  }

  Future<Media> insertMedia(
      {required String location, required int collectionId}) async {
    DateTime dt = DateTime.now();

    final Map<String, dynamic> mediaJson = {
      'location': location,
      'collectionId': collectionId,
      'createdAt': dt.toIso8601String(),
    };

    int id = await db.insert('Media', mediaJson);

    print("INSERTED Media ID  : $id");

    mediaJson['id'] = id;

    if (id != 0) {
      return Media.fromJson(mediaJson);
    } else {
      throw Exception("Collection error");
    }
  }
}
