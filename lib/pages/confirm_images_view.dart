import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_warden/models/collection_model.dart';
import 'package:note_warden/providers/images_provider.dart';
import 'package:note_warden/providers/media_provider.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:provider/provider.dart';

class ConfirmImagesView extends StatelessWidget {
  const ConfirmImagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final imageViewModel = Provider.of<ImagesProvider>(context);
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm your Notes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: InteractiveViewer(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.file(File(imageViewModel.imagePath)),
          ),
        ),
      ),
      floatingActionButton: Consumer<MediaProvider>(
        builder: (context,viewModel,child) {
          return FloatingActionButton(
            onPressed: (){
              
              viewModel.addMedia(collection: collection, filePath: imageViewModel.imagePath);
              Navigator.pushReplacementNamed(context, "/");
            },
            child: changeFAB(viewModel.addMediaState)
            // const Icon(Icons.done),
          );
        }
      ),
    );
  }

  Widget changeFAB(TaskState taskState){
    if(taskState == TaskState.loading){
      return const CircularProgressIndicator();
    }
    else if(taskState == TaskState.failure){
      return const Icon(Icons.refresh);
    }
    else {
      return const Icon(Icons.done);
    }
  }
}
