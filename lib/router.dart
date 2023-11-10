import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_warden/features/feature_collection/domain/model/collection_model.dart';
import 'package:note_warden/features/feature_media/presentation/media_list/views/media_list_screen.dart';
import 'package:note_warden/features/feature_settings/presentation/settings_screen.dart';
import 'package:note_warden/features/skeleton/presentation/main_screen.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/collection_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScreen(
          shellContext: _shellNavigatorKey.currentContext,
          child: child,
        );
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => CollectionScreen()),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/media',
          name: "media",
          builder: (context, state) {
            Collection collection = state.extra as Collection;
            return MediaListScreen(
              collection: collection,
            );
          },
        ),
      ],
    ),
  ],
);
