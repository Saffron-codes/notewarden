import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_warden/injection_container.dart';
import 'package:note_warden/providers/media_provider.dart';
import 'package:note_warden/services/file_picker_service.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:note_warden/widgets/empty_list_guide.dart';
import 'package:note_warden/widgets/media_list_shimmer.dart';
import 'package:note_warden/widgets/pdf_card.dart';
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

  void addMedia(BuildContext context, Collection collection,
      List<String> filePaths) async {
    Provider.of<MediaProvider>(context, listen: false)
        .addMedia(collection: collection, pathsfromPicker: filePaths);
    await Future.delayed(const Duration(milliseconds: 500));
    Provider.of<MediaProvider>(context, listen: false)
        .loadMedia(collectionId: collection.id);
  }

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;

    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
        actions: [
          Consumer<MediaProvider>(
            builder: (context, viewModel, child) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  viewModel.media.length.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final filePaths = await sl<FilePickerService>().pickMultipleFiles();
          addMedia(context, collection, filePaths);
        },
        child: const Icon(
          Icons.add_a_photo_rounded,
        ),
      ),
      body: Consumer<MediaProvider>(builder: (context, viewModel, child) {
        if (viewModel.loadMediaState == TaskState.loading) {
          return const MediaListShimmer();
        } else if (viewModel.loadMediaState == TaskState.success) {
          return viewModel.media.isNotEmpty?
          Padding(
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
                return viewModel.media[index].location.endsWith(".pdf")
                    ? PDFCard(
                        pdfInfo: viewModel.media[index],
                      )
                    : GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          "/media/detailed",
                          arguments: {
                            "firstImg": index,
                            "collectionId": collection.id
                          },
                        ),
                        child: Container(
                          height: 200.0, // Fixed height for the card
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                File(viewModel.media[index].location),
                              ), // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
              },
            ),
          ):EmptyListGuide(isForCollection: false);
        } else {
          return const MediaListShimmer();
        }
      }),
    );
  }
}
