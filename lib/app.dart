import 'package:flutter/material.dart';
import 'package:note_warden/injection_container.dart';
import 'package:note_warden/pages/confirm_images_view.dart';
import 'package:note_warden/providers/collection_provider.dart';
import 'package:note_warden/providers/images_provider.dart';
import 'package:note_warden/providers/media_provider.dart';
import 'package:note_warden/services/collection_service.dart';
import 'package:note_warden/services/media_service.dart';
import 'package:provider/provider.dart';
import 'package:note_warden/pages/collection_detailed_view.dart';
import 'package:note_warden/pages/decider_view.dart';
import 'package:note_warden/pages/select_collections_view.dart';

import 'pages/collections_view.dart';

class NoteWarden extends StatelessWidget {
  const NoteWarden({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CollectionProvider(
            collectionService: sl<CollectionService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MediaProvider(mediaService: sl<MediaService>()),
        ),
      ],
      child: MaterialApp(
        title: 'Note Warden',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0F547D),brightness: Brightness.dark,onPrimary: Color(0xff2D2F31)),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        initialRoute: "/",
        routes: {
          "/": (context) => const DeciderView(),
          "/collections": (context) => CollectionsView(),
          "/collection": (context) => const CollectionDetailedView(),
          "/collection/choose": (context) => const SelectCollectionsView(),
          "/confirm_images": (context) => const ConfirmImagesView()
        },
      ),
    );
  }
}
