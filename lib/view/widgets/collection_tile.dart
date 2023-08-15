import 'package:flutter/material.dart';
import 'package:note_warden/models/collection_model.dart';
import 'package:note_warden/view/providers/settings_provider.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:note_warden/view/widgets/bottom_sheets/collection_options_sheet.dart';
import 'package:provider/provider.dart';

import '../../utils/convert_to_ago.dart';

class CollectionTile extends StatelessWidget {
  final Collection collection;
  final Function() onPressed;
  const CollectionTile(
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
            builder: (context)=>  CollectionOptionsSheet(collection: collection,)
          );
        },
        child: Consumer<SettingsProvider>(
          builder: (context,viewModel,child) {
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(collection.name),
                  ),
                  Text(viewModel.listorder == ListOrder.byCreation?
                    formatDateTimeAgo(collection.createdAt):formatDateTimeAgo(collection.updatedAt),
                      style: const TextStyle(fontSize: 10)),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
