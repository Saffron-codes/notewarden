import 'package:flutter/material.dart';
import 'package:note_warden/view/providers/collection_provider.dart';
import 'package:note_warden/view/widgets/collection_tile.dart';
import 'package:provider/provider.dart';

import '../../utils/enums.dart';

class SelectCollectionsView extends StatefulWidget {
  const SelectCollectionsView({Key? key}) : super(key: key);

  @override
  State<SelectCollectionsView> createState() => _SelectCollectionsViewState();
}

class _SelectCollectionsViewState extends State<SelectCollectionsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CollectionProvider>(context, listen: false).loadCollections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a Collection"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<CollectionProvider>(
        builder: (context, viewModel, child) {
          // print("VM :-> ${viewModel.addCollectionState}");
          if (viewModel.loadCollectionsState == TaskState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModel.loadCollectionsState == TaskState.success) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return CollectionTile(
                  collection: viewModel.collections[index],
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/confirm_images',arguments: viewModel.collections[index]),
                );
              },
              itemCount: viewModel.collections.length,
            );
          } else {
            return const Text("None");
          }
        },
      ),
    );
  }
}
