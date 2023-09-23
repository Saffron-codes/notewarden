import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/core/presentation/util/convert_to_ago.dart';
import 'package:note_warden/feature_collection/domain/model/collection_model.dart';
import 'package:note_warden/feature_collection/domain/util/collection_order.dart';

import '../bottom_sheet/collection_sheet.dart';
import '../collections_bloc/collections_bloc.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  final Function() onPressed;
  const CollectionCard(
      {super.key, required this.collection, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onPressed,
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (context) => CollectionSheet(
                    collection: collection,
                  ));
        },
        child: BlocBuilder<CollectionsBloc, CollectionsState>(
          builder: (context, state) {
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(collection.name),
                  ),
                  state is CollectionsLoaded
                      ? Text(
                          state.collectionOrder == CollectionOrder.byCreation
                              ? formatDateTimeAgo(collection.createdAt)
                              : formatDateTimeAgo(collection.updatedAt),
                          style: const TextStyle(fontSize: 10))
                      : Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
