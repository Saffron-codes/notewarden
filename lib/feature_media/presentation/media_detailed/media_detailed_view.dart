import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_media/presentation/dialog/media_info_dialog.dart';

import '../../../core/presentation/dialog/confirmation_dialog.dart';
import '../media_list/media_bloc/media_bloc.dart';

class MediaDetailedView extends StatelessWidget {
  const MediaDetailedView({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocConsumer<MediaBloc, MediaState>(
      builder: (context, state) {
        if (state is MediaLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MediaLoaded) {
          return PageView.builder(
            itemCount: state.media.length,
            controller: PageController(initialPage: data["initialPage"]),
            itemBuilder: (context, index) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("${index + 1}/${state.media.length}"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmationDialog(
                            title: "Delete Media",
                            content:
                                "Media will be removed from the collection",
                            onPressedOK: () {
                              BlocProvider.of<MediaBloc>(context, listen: false)
                                  .add(DeleteMediaEvent(state.media[index]));
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                      tooltip: "Delete",
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => MediaInfoDialog(
                            media: state.media[index],
                          ),
                        );
                      },
                      icon: const Icon(Icons.info),
                      tooltip: "Media Info",
                    )
                  ],
                ),
                body: state.media[index].location.endsWith(".pdf")
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                state.media[index].location.split('/').last,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            FilledButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/media/pdf",
                                    arguments: state.media[index]);
                              },
                              child: const Text("Open"),
                            )
                          ],
                        ),
                      )
                    : InteractiveViewer(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  FileImage(File(state.media[index].location)),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      listener: (BuildContext context, MediaState state) {
        if (state is MediaLoaded && state.media.isEmpty) {
          Navigator.pop(context);
        }
      },
    );
    // return BlocBuilder<MediaBloc, MediaState>(
    //   builder: (context, state) {
    //     if (state is MediaLoading) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if (state is MediaLoaded) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           actions: [
    //             IconButton(
    //               onPressed: () {
    //                 //TODO
    //                 // final media = viewModel.media[curMedia];
    //                 showDialog(
    //                   context: context,
    //                   builder: (_) => ConfirmationDialog(
    //                     title: "Delete Media",
    //                     content: "Media will be removed from the collection",
    //                     onPressedOK: () {
    //                       BlocProvider.of<MediaBloc>(context, listen: false)
    //                           .add(DeleteMediaEvent(state.media[index]));
    //                       Navigator.pop(context);
    //                     },
    //                   ),
    //                 );
    //               },
    //               icon: Icon(Icons.delete),
    //               tooltip: "Delete",
    //             ),
    //           ],
    //         ),
    //         body: PageView.builder(
    //           itemCount: state.media.length,
    //           controller: PageController(initialPage: data["initialPage"]),
    //           itemBuilder: (context, index) {
    //             return state.media[index].location.endsWith(".pdf")
    //                 ? Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       SizedBox(
    //                         child: Text(
    //                           state.media[index].location.split('/').last,
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                       FilledButton(
    //                         onPressed: () async {
    //                           // await OpenFile.open(media.location);
    //                           //TODO:
    //                           // Navigator.pushNamed(context, "/pdf", arguments: media);
    //                         },
    //                         child: const Text("Open"),
    //                       )
    //                     ],
    //                   )
    //                 : InteractiveViewer(
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         image: DecorationImage(
    //                           image:
    //                               FileImage(File(state.media[index].location)),
    //                           // fit: BoxFit.cover,
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //           },
    //         ),
    //       );
    //     } else {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );
  }
}
