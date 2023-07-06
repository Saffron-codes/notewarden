import 'package:flutter/material.dart';

class EmptyListGuide extends StatelessWidget {
  bool isForCollection;
  EmptyListGuide({super.key, required this.isForCollection});
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isForCollection? Icon(Icons.note, size: 44):Icon(Icons.file_open, size: 44),
          SizedBox(height: 16),
          Text(
            isForCollection? 'No collections found':'No media found',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Tap the + button to add new ${isForCollection?'collection':'media'}.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
