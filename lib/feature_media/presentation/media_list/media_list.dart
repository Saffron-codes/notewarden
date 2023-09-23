import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_media/presentation/media_list/widgets/media_grid_list.dart';

import '../../../feature_collection/domain/model/collection_model.dart';
import 'media_bloc/media_bloc.dart';

class MediaList extends StatelessWidget {
  const MediaList({super.key});

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

  @override
  Widget build(BuildContext context) {
    final col = ModalRoute.of(context)!.settings.arguments as Collection;
    BlocProvider.of<MediaBloc>(context).add(GetMediaListEvent(col.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(col.name),
        actions: [
          BlocBuilder<MediaBloc, MediaState>(
            builder: (context, state) {
              if (state is MediaLoading) {
                return CircularProgressIndicator();
              } else if (state is MediaLoaded) {
                return IconButton(
                  onPressed: null,
                  icon: Text(
                    state.media.length.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          if (state is MediaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MediaLoaded) {
            return MediaGridList(media: state.media, collectionId: col.id);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final files = await pickMultipleFiles();

          BlocProvider.of<MediaBloc>(context, listen: false)
              .add(AddMediaEvent(col.name, col.id, files));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
