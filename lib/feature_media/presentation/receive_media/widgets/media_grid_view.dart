import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class MediaGridView extends StatelessWidget {
  final List<SharedMediaFile> files;
  const MediaGridView({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: files.length,
        itemBuilder: (context, index) {
          return Container(
            height: 200.0, // Fixed height for the card
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                  File(files[index].path),
                ), // Replace with your image path
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        },
      ),
    );
  }
}
