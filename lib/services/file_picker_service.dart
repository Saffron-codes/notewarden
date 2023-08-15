import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<List<String>> pickMultipleFiles() async {
    List<String> filePaths = [];

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpeg'],
      );

      if (result != null) {
        for (PlatformFile file in result.files) {
          filePaths.add(file.path!);
        }
      }
    } catch (e) {
      // Handle error if any
      print('Error picking files: $e');
    }

    return filePaths;
  }
}
