import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_app_updater/presentation/app_updater_bloc/app_updater_bloc.dart';
import 'package:note_warden/feature_app_updater/presentation/bottom_sheet/app_release_info_sheet.dart';
import 'package:note_warden/feature_app_updater/presentation/bottom_sheet/beta_updates_sheet.dart';
import 'package:note_warden/feature_collection/presentation/collection_search/collection_search_delegate.dart';
import 'package:note_warden/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
import 'package:note_warden/feature_collection/presentation/collections/dialog/add_collection_dialog.dart';
import 'package:note_warden/feature_collection/presentation/collections/widgets/collection_card.dart';
import 'package:note_warden/feature_collection/presentation/collections/widgets/collection_list_shimmer.dart';
import 'package:note_warden/feature_collection/presentation/collections/widgets/empty_list_guide.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Warden"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            tooltip: "Search",
            onPressed: () {
              showSearch(
                  context: context, delegate: CollectionSearchDelegate());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            tooltip: "Settings",
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
          )
        ],
      ),
      body: BlocConsumer<AppUpdaterBloc, AppUpdaterState>(
          listener: (BuildContext context, AppUpdaterState state) {
        if (state is AppUpdaterLoaded && state.appUpdateInfo.updateAvailable) {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (_) => AppReleaseInfoSheet(
                state.appUpdateInfo.version, state.appUpdateInfo.md),
          );
        } else if (state is AppUpdaterBetaCheck) {
          showModalBottomSheet(
              context: context, builder: (_) => const BetaUpdatesSheet());
        }
      }, builder: (context, state) {
        return BlocBuilder<CollectionsBloc, CollectionsState>(
          builder: (context, state) {
            if (state is CollectionsLoaded) {
              return state.collections.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.collections.length,
                      itemBuilder: (context, index) => CollectionCard(
                        collection: state.collections[index],
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/media",
                            arguments: state.collections[index],
                          );
                        },
                      ),
                    )
                  : const EmptyListGuide(
                      isForCollection: true,
                    );
            } else if (state is CollectionsLoading) {
              return const CollectionListShimmer();
            } else {
              return const CollectionListShimmer();
            }
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddCollectionDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
