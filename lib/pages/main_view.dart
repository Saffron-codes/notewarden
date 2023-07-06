import 'package:flutter/material.dart';
import 'package:note_warden/pages/collections_view.dart';
import 'package:note_warden/pages/select_collections_view.dart';
import 'package:note_warden/pages/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../providers/shared_media_provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReceiveSharingIntent.getInitialMedia(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashView();
        }

        if (snapshot.hasData) {
          final files = snapshot.data;
          if(files != null && files.isNotEmpty){
            Provider.of<SharedMediaProvider>(context,listen: false).addFiles(files);
            return const SelectCollectionsView();
          }
          else{
            return CollectionsView();
          }
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
