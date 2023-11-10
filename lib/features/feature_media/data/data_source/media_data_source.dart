import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    // if (await Permission.manageExternalStorage.request().isGranted ||
    //     await Permission.storage.request().isGranted) {
    Directory? downloadsDir = await getDownloadsDirectory();

    if (downloadsDir != null) {
      String subFolderPath =
          p.join(downloadsDir.path, "NoteWarden", collectionName);

      String fileName = p.basename(filePath);

      if (!await Directory(subFolderPath).exists()) {
        await Directory(subFolderPath).create(recursive: true);
        print("Created Sub Folder");
      }

      print("Sub Folder already exists");

      String finalFilePath = p.join(subFolderPath, fileName);

      File newFile = await File(filePath).copy(finalFilePath);

      print(newFile.path);

      // Directory subDirectory =
      //     Directory('${externalDirectory.path}/NoteWarden/$collectionName');

      // if (!await subDirectory.exists()) {
      //   await subDirectory.create(recursive: true);
      // }

      // // print(subDirectory);

      // // Get the file name from the image path
      // String fileName = filePath.split('/').last;

      // // Create the destination file path in the external directory
      // String destinationPath = p.join(subDirectory.path, fileName);
      // print(destinationPath);
      // // Copy the image file to the destination path
      // File newFile = await File(filePath).copy(destinationPath);

      // print(newFile.path);

      // // Optional: Verify if the image file exists in the external directory
      // File copiedImageFile = File(destinationPath);
      if (await newFile.exists()) {
        // print('Image saved to external directory successfully!');
        try {
          await insertMedia(finalFilePath, collectionId);
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
    // }
    //  else {
    //   openAppSettings();
    //   return;
    // }
  }
}
