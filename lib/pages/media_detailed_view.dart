import 'dart:io';
import 'package:flutter/material.dart';

class MediaDetailedView extends StatefulWidget {
  const MediaDetailedView({super.key});

  @override
  State<MediaDetailedView> createState() => _MediaDetailedViewState();
}

class _MediaDetailedViewState extends State<MediaDetailedView> {
  int curMedia = 1;
  bool isShowingBar = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    curMedia = mediaData["firstImg"];
  }

  @override
  Widget build(BuildContext context) {
    final mediaData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _mediaPageController =
        PageController(initialPage: mediaData["firstImg"]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isShowingBar
          ? AppBar(
              title: Text("${curMedia+1} / ${mediaData["media"].length}"),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            )
          : null,
      body: PageView.builder(
        itemCount: mediaData["media"].length,
        controller: _mediaPageController,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  isShowingBar = !isShowingBar;
                });
              },
              child: InteractiveViewer(
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(mediaData["media"][index].location)),
                    fit: BoxFit.cover,
                  ),
                )),
              ));
        },
        onPageChanged: (value) {
          setState(() {
            curMedia = value;
          });
          // print(curMedia);
        },
      ),
    );
  }
}
