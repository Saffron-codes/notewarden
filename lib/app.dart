import 'package:flutter/material.dart';
import 'package:note_warden/injection_container.dart';
import 'package:note_warden/pages/confirm_images_view.dart';
import 'package:note_warden/pages/main_view.dart';
import 'package:note_warden/pages/media_detailed_view.dart';
import 'package:note_warden/pages/pdf_preview_view.dart';
import 'package:note_warden/pages/report_view.dart';
import 'package:note_warden/providers/collection_provider.dart';
import 'package:note_warden/providers/report_provider.dart';
import 'package:note_warden/providers/settings_provider.dart';
import 'package:note_warden/providers/shared_media_provider.dart';
import 'package:note_warden/providers/media_provider.dart';
import 'package:note_warden/services/cache_service.dart';
import 'package:note_warden/services/collection_service.dart';
import 'package:note_warden/services/media_service.dart';
import 'package:note_warden/services/report_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:note_warden/pages/collection_detailed_view.dart';
import 'package:note_warden/pages/select_collections_view.dart';

import 'pages/collections_view.dart';
import 'pages/settings_view.dart';

class NoteWarden extends StatelessWidget {
  const NoteWarden({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CollectionProvider(
            collectionService: sl<CollectionService>(),
            cacheService: sl<CacheService>()
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedMediaProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MediaProvider(mediaService: sl<MediaService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(cacheService: sl<CacheService>(),packageInfo: sl<PackageInfo>()),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportProvider(reportService: sl<ReportService>()),
        )
      ],
      child: Consumer<SettingsProvider>(
        builder: (context,viewModel,child) {
          return MaterialApp(
            title: 'Note Warden',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
              useMaterial3: true,
              
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0F547D),brightness: Brightness.dark,onPrimary: const Color(0xff2D2F31)),
              useMaterial3: true,
            ),
            themeMode: viewModel.themeMode,
            initialRoute: "/",
            routes: {
              "/": (context) => const MainView(),
              "/collections": (context) => CollectionsView(),
              "/collection": (context) => const CollectionDetailedView(),
              "/collection/choose": (context) => const SelectCollectionsView(),
              "/confirm_images": (context) => const ConfirmImagesView(),
              "/media/detailed":(context) => const MediaDetailedView(),
              "/pdf":(context) => const PDFPreview(),
              "/settings":(context) => const SettingsView(),
              "/report":(context) => const ReportView()
            },
          );
        }
      ),
    );
  }
}
