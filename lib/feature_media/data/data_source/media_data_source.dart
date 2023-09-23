import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/model/media_model.dart';

abstract class MediaDataSource {
  Future<List<Media>> getMediaList(int collectionId);

  Future<Media> insertMedia(String location, int collectionId);

  Future<void> deleteMedia(Media media);

  Future<void> saveMedia(
    String collectionName,
    int collectionId,
    String filePath,
  );
}

class MediaDataSourceImpl implements MediaDataSource {
  final Database db;
  const MediaDataSourceImpl(this.db);

  @override
  Future<void> deleteMedia(Media media) async {
    File file = File(media.location);

    try {
      file.deleteSync();
      await db.delete("Media", where: "id=?", whereArgs: [media.id]);
    } catch (e) {
      throw Exception("Delete Media Error");
    }
  }

  @override
  Future<List<Media>> getMediaList(int collectionId) async {
    final rawMedia = await db
        .query("Media", where: "collectionId = ?", whereArgs: [collectionId]);
    return List<Media>.from(rawMedia.map((model) => Media.fromJson(model)));
  }

  @override
  Future<Media> insertMedia(String location, int collectionId) async {
    DateTime dt = DateTime.now();

    final Map<String, dynamic> mediaJson = {
      'location': location,
      'collectionId': collectionId,
      'createdAt': dt.toIso8601String(),
    };

    int id = await db.insert('Media', mediaJson);

    print("INSERTED Media ID  : $id");

    // Update the [updatedAt] value to [DateTime.now()]

    await db.update("Collection", {"updatedAt": dt.toIso8601String()},
        where: 'id=?', whereArgs: [collectionId]);

    // // log the task
    // logger.i("Updated the [updatedAt] value to [DateTime.now()]");

    mediaJson['id'] = id;

    if (id != 0) {
      return Media.fromJson(mediaJson);
    } else {
      throw Exception("Collection error");
    }
  }

  @override
  Future<void> saveMedia(
      String collectionName, int collectionId, String filePath) async {
    if (await Permission.manageExternalStorage.request().isGranted ||
        await Permission.storage.request().isGranted) {
      Directory? externalDirectory = await getExternalStorageDirectory();

      if (externalDirectory != null) {
        // Create a subdirectory within the external directory (optional)
        int index = externalDirectory.path.indexOf("/0/");
        String path = externalDirectory.path.substring(0, index + 3);
        Directory subDirectory = Directory('$path/NoteWarden/$collectionName');
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
            await insertMedia(destinationPath, collectionId);
            // logger.i("Media DB Done");
          } catch (e) {
            // logger.e("Media DB Error");
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
}
