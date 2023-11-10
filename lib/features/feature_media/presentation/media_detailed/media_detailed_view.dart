import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_warden/features/feature_media/presentation/dialog/media_info_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;

import '../../../../core/presentation/dialog/confirmation_dialog.dart';
import '../media_list/media_bloc/media_bloc.dart';

class MediaDetailedView extends StatefulWidget {
  final int initialPage;
  final int collectionId;
  const MediaDetailedView({
    super.key,
    required this.initialPage,
    required this.collectionId,
  });

  @override
  State<MediaDetailedView> createState() => _MediaDetailedViewState();
}

class _MediaDetailedViewState extends State<MediaDetailedView> {
  int currentIndex = 0;
  @override
  void initState() {
    setState(() {
      currentIndex = widget.initialPage;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      builder: (context, state) {
        if (state is MediaLoading) {
          return const Center(
            child: ProgressRing(),
          );
        } else if (state is MediaLoaded) {
          return RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (event) {
              if (event is RawKeyDownEvent) {
                if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                  if (currentIndex > 0) {
                    setState(() {
                      currentIndex--;
                    });
                  }
                } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                  if (currentIndex < state.media.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                  }
                } else if (event.isKeyPressed(LogicalKeyboardKey.escape) &&
                    context.canPop()) {
                  context.pop();
                }
              }
            },
            child: NavigationView(
              content: Focus(
                child: ScaffoldPage(
                  header: PageHeader(
                    padding: 10,
                    title: Text(" ${currentIndex + 1}/${state.media.length}"),
                    leading: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(fi.FluentIcons.arrow_left_24_regular),
                      ),
                    ),
                    commandBar: CommandBar(
                      mainAxisAlignment: MainAxisAlignment.end,
                      primaryItems: [
                        CommandBarBuilderItem(
                          builder: (context, mode, w) => Tooltip(
                            message: "Delete File",
                            child: w,
                          ),
                          wrappedItem: CommandBarButton(
                            icon: const Icon(fi.FluentIcons.delete_24_regular),
                            label: const Text('Delete'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => ConfirmationDialog(
                                  title: "Delete Media",
                                  content:
                                      "Media will be removed from the collection",
                                  onPressedOK: () {
                                    BlocProvider.of<MediaBloc>(context,
                                            listen: false)
                                        .add(
                                      DeleteMediaEvent(
                                        state.media[currentIndex],
                                      ),
                                    );
                                    Navigator.pop(context);

                                    if (currentIndex != 0) {
                                      if (state.media.length - 1 !=
                                          currentIndex) {
                                        setState(() {
                                          currentIndex++;
                                        });
                                      } else {
                                        setState(() {
                                          currentIndex--;
                                        });
                                      }
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const CommandBarSeparator(),
                        CommandBarBuilderItem(
                          builder: (context, mode, w) => Tooltip(
                            message: "File Info",
                            child: w,
                          ),
                          wrappedItem: CommandBarButton(
                            icon: const Icon(fi.FluentIcons.info_24_regular),
                            label: const Text('Info'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => MediaInfoDialog(
                                  media: state.media[currentIndex],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  content: state.media.isNotEmpty
                      ? state.media[currentIndex].location.endsWith(".pdf")
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      state.media[currentIndex].location
                                          .split('/')
                                          .last,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  FilledButton(
                                    onPressed: () async {
                                      await OpenFile.open(
                                          state.media[currentIndex].location);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text("Open"),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Hero(
                              tag: "image-${widget.initialPage}",
                              child: InteractiveViewer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.scaleDown,
                                      image: FileImage(File(
                                          state.media[currentIndex].location)),
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : Container(),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: ProgressRing(),
          );
        }
      },
      listener: (BuildContext context, MediaState state) {
        if (state is MediaLoaded && state.media.isEmpty) {
          Navigator.pop(context);
        }
      },
    );
  }
}

// class MediaViewContainer extends StatelessWidget {
//   final Media media;
//   const MediaViewContainer({super.key, required this.media});

//   @override
//   Widget build(BuildContext context) {
//     return NavigationView(
//       content: ScaffoldPage(
//         header: PageHeader(
//           padding: 10,
//           title: Text("${index + 1}/${state.media.length}"),
//           leading: IconButton(
//             onPressed: () => context.pop(),
//             icon: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(FluentIcons.back),
//             ),
//           ),
//           commandBar: CommandBar(
//             mainAxisAlignment: MainAxisAlignment.end,
//             primaryItems: [
//               CommandBarBuilderItem(
//                 builder: (context, mode, w) => Tooltip(
//                   message: "Delete File",
//                   child: w,
//                 ),
//                 wrappedItem: CommandBarButton(
//                   icon: const Icon(FluentIcons.delete),
//                   label: const Text('Delete'),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (_) => ConfirmationDialog(
//                         title: "Delete Media",
//                         content: "Media will be removed from the collection",
//                         onPressedOK: () {
//                           BlocProvider.of<MediaBloc>(context, listen: false)
//                               .add(DeleteMediaEvent(state.media[index]));
//                           Navigator.pop(context);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const CommandBarSeparator(),
//               CommandBarBuilderItem(
//                 builder: (context, mode, w) => Tooltip(
//                   message: "File Info",
//                   child: w,
//                 ),
//                 wrappedItem: CommandBarButton(
//                   icon: const Icon(FluentIcons.info),
//                   label: const Text('Info'),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => MediaInfoDialog(
//                         media: state.media[index],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         content: state.media[index].location.endsWith(".pdf")
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       child: Text(
//                         state.media[index].location.split('/').last,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     FilledButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, "/media/pdf",
//                             arguments: state.media[index]);
//                       },
//                       child: const Text("Open"),
//                     )
//                   ],
//                 ),
//               )
//             : InteractiveViewer(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.scaleDown,
//                       image: FileImage(File(state.media[index].location)),
//                       // fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
