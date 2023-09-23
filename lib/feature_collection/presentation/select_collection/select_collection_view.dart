import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
import 'package:note_warden/feature_collection/presentation/collections/widgets/collection_list_shimmer.dart';

import '../collections/widgets/collection_card.dart';
import '../collections/widgets/empty_list_guide.dart';

class SelectCollectionsView extends StatelessWidget {
  const SelectCollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose a Collection"),
        ),
        body: BlocBuilder<CollectionsBloc, CollectionsState>(
          builder: (context, state) {
            if (state is CollectionsLoaded) {
              return state.collections.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.collections.length,
                      itemBuilder: (context, index) => CollectionCard(
                        collection: state.collections[index],
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/media/confirm_media',
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
        ));
  }
}
