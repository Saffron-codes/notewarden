import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CollectionDetailedView extends StatelessWidget {
  const CollectionDetailedView({super.key});


  void writeFile()async{
    Directory appDir = await getApplicationDocumentsDirectory();
    File myFile = File("${appDir.path}/hello.txt");
    // await myFile.writeAsString("Hello, World");
    var data = await myFile.readAsString();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(""),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>writeFile(),
        child: const Icon(
          Icons.add_a_photo_rounded,
        ),
      ),
    );
  }
}
