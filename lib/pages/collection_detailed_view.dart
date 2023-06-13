import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_warden/providers/collection_provider.dart';
import 'package:note_warden/providers/media_provider.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../models/collection_model.dart';

class CollectionDetailedView extends StatefulWidget {
  const CollectionDetailedView({super.key});

  @override
  State<CollectionDetailedView> createState() => _CollectionDetailedViewState();
}

class _CollectionDetailedViewState extends State<CollectionDetailedView> {
  Collection? collection;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CollectionProvider>(context, listen: false)
          .loadMediaCount(collectionId: collection!.id);
      Provider.of<MediaProvider>(context, listen: false)
          .loadMedia(collectionId: collection!.id);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final col = ModalRoute.of(context)!.settings.arguments as Collection;
    collection = col;
  }

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(collection.name),
        actions: [
          Consumer<CollectionProvider>(
            builder: (context, viewModel, child) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(viewModel.mediaCount.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Permission.manageExternalStorage.request();
          print(result);
          // openAppSettings();
        },
        child: const Icon(
          Icons.add_a_photo_rounded,
        ),
      ),
      body: Consumer<MediaProvider>(builder: (context, viewModel, child) {
        if (viewModel.loadMediaState == TaskState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (viewModel.loadMediaState == TaskState.success) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: viewModel.media.length,
              itemBuilder: (context, index) {
                return Container(
                    height: 200.0, // Fixed height for the card
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(viewModel.media[index]
                            .location)), // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ));
              },
            ),
          );
        } else {
          return Text("None");
        }
      }),
    );
  }
}
