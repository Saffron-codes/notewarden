import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_warden/models/media.dart';
import 'package:note_warden/view/providers/media_provider.dart';
import 'package:note_warden/view/widgets/dialogs/confirmation_dialog.dart';
import 'package:note_warden/view/widgets/dialogs/file_info_dialog.dart';
import 'package:provider/provider.dart';

class MediaDetailedView extends StatefulWidget {
  const MediaDetailedView({super.key});

  @override
  State<MediaDetailedView> createState() => _MediaDetailedViewState();
}

class _MediaDetailedViewState extends State<MediaDetailedView> {
  int curMedia = 1;
  bool isShowingBar = true;
  var mediaData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    curMedia = mediaData["firstImg"];
  }

  @override
  Widget build(BuildContext context) {
    mediaData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final mediaPageController =
        PageController(initialPage: mediaData["firstImg"]);
    return Consumer<MediaProvider>(builder: (context, viewModel, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: isShowingBar
            ? AppBar(
                title: Text("${curMedia + 1} / ${viewModel.media.length}"),
                actions: [
                  IconButton(
                    onPressed: () {
                      final media = viewModel.media[curMedia];
                      showDialog(
                        context: context,
                        builder: (_) => ConfirmationDialog(
                          title: "Delete Media",
                          content: "Media will be removed from the collection",
                          onPressedOK: () {
                            Provider.of<MediaProvider>(context, listen: false)
                            .deleteMedia(media,curMedia);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                    tooltip: "Delete",
                  ),
                  IconButton(
                    onPressed: () {
                      final media = viewModel.media[curMedia];
                      showDialog(
                        context: context,
                        builder: (context) => MediaInfoDialog(
                          media: media,
                        ),
                      );
                    },
                    icon: const Icon(Icons.info),
                    tooltip: "Media Info",
                  )
                ],
              )
            : null,
        body: PageView.builder(
          controller: mediaPageController,
          itemCount: viewModel.media.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isShowingBar = !isShowingBar;
                });
              },
              child: updateView(viewModel.media[index], index),
            );
          },
          onPageChanged: (value) {
            setState(() {
              curMedia = value;
            });
          },
        ),
      );
    });
  }

  Widget updateView(Media media, int index) {
    if (media.location.endsWith(".pdf")) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(
              media.location.split('/').last,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          FilledButton(
            onPressed: () async {
              // await OpenFile.open(media.location);
              Navigator.pushNamed(context, "/pdf", arguments: media);
            },
            child: const Text("Open"),
          )
        ],
      );
    } else {
      return InteractiveViewer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(media.location)),
              // fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }
}
