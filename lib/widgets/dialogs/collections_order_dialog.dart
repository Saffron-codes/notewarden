import 'package:flutter/material.dart';
import 'package:note_warden/providers/collection_provider.dart';
import 'package:note_warden/providers/settings_provider.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:provider/provider.dart';

class CollectionsOrderDialog extends StatelessWidget {
  const CollectionsOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Consumer<SettingsProvider>(builder: (context, viewModel, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("By time of creation"),
              onTap: () {
                viewModel.listorder = ListOrder.byCreation;
                Provider.of<CollectionProvider>(context,listen: false).loadCollections();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("By time of modifications"),
              onTap: () {
                viewModel.listorder = ListOrder.byModification;
                Provider.of<CollectionProvider>(context,listen: false).loadCollections();
                Navigator.pop(context);
              },
            )
          ],
        );
      }),
    );
  }
}
