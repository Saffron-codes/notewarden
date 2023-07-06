import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_warden/models/collection_model.dart';
import 'package:note_warden/providers/shared_media_provider.dart';
import 'package:note_warden/providers/media_provider.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:note_warden/widgets/image_preview.dart';
import 'package:note_warden/widgets/media_grid_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ConfirmImagesView extends StatefulWidget {
  const ConfirmImagesView({super.key});

  @override
  State<ConfirmImagesView> createState() => _ConfirmImagesViewState();
}

class _ConfirmImagesViewState extends State<ConfirmImagesView> {
  static const platform = MethodChannel("com.notewarden");

  Future<void> requestPermission() async {
    var apiLevel = await platform.invokeMethod('getApiLevel');
    if (apiLevel >= 33) {
      await Permission.manageExternalStorage.request();
    } else {
      await Permission.storage.request();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final sharedFilesViewModel = Provider.of<SharedMediaProvider>(context);
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm your Notes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: sharedFilesViewModel.mediaFiles.length > 1
          ? MediaGridView(files: sharedFilesViewModel.mediaFiles)
          : MediaPreview(path: sharedFilesViewModel.mediaFiles[0].path),
      floatingActionButton: Consumer<MediaProvider>(
        builder: (context, viewModel, child) {
          return FloatingActionButton(
              onPressed: () {
                viewModel.addMedia(
                    collection: collection,
                    filePaths: sharedFilesViewModel.mediaFiles);
                Navigator.pushReplacementNamed(context, "/collections");
              },
              child: changeFAB(viewModel.addMediaState)
              // const Icon(Icons.done),
              );
        },
      ),
    );
  }

  Widget changeFAB(TaskState taskState) {
    if (taskState == TaskState.loading) {
      return const CircularProgressIndicator();
    } else if (taskState == TaskState.failure) {
      return const Icon(Icons.refresh);
    } else {
      return const Icon(Icons.done);
    }
  }
}
