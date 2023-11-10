import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/features/feature_collection/domain/model/collection_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;

import '../media_bloc/media_bloc.dart';
import '../widgets/media_grid_list.dart';

class MediaListScreen extends StatelessWidget {
  final Collection collection;
  const MediaListScreen({super.key, required this.collection});

  Future<List<String>> pickMultipleFiles() async {
    List<String> filePaths = [];

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
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
    BlocProvider.of<MediaBloc>(context, listen: false)
        .add(GetMediaListEvent(collection.id));
    return ScaffoldPage(
      header: PageHeader(
        title: Text(collection.name),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarBuilderItem(
              builder: (context, mode, w) => Tooltip(
                message: "Add New Files",
                child: w,
              ),
              wrappedItem: CommandBarButton(
                icon: const Icon(fi.FluentIcons.add_24_regular),
                label: const Text('New'),
                onPressed: () async {
                  final files = await pickMultipleFiles();

                  BlocProvider.of<MediaBloc>(context, listen: false).add(
                      AddMediaEvent(collection.name, collection.id, files));
                },
              ),
            ),
          ],
        ),
      ),
      content: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          if (state is MediaLoading) {
            return const Center(
              child: ProgressRing(),
            );
          } else if (state is MediaLoaded) {
            return MediaGridList(
              media: state.media,
              collectionId: collection.id,
            );
          } else {
            return const Center(
              child: ProgressRing(),
            );
          }
        },
      ),
    );
  }
}
