import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/core/presentation/pages/splash_view.dart';
import 'package:note_warden/feature_collection/presentation/collections/collections_view.dart';
import 'package:note_warden/feature_collection/presentation/select_collection/select_collection_view.dart';
import 'package:note_warden/feature_media/presentation/receive_media/receive_media_cubit/receive_media_cubit.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ReceiveMediaView extends StatelessWidget {
  final BuildContext rootContext;
  const ReceiveMediaView({super.key, required this.rootContext});

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
          if (files != null && files.isNotEmpty) {
            BlocProvider.of<ReceiveMediaCubit>(rootContext, listen: false)
                .addMediaFiles(files);
            return const SelectCollectionsView();
          } else {
            return const CollectionScreen();
          }
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
