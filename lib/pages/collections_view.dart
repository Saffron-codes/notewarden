import 'package:flutter/material.dart';
import 'package:note_warden/providers/collection_provider.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:provider/provider.dart';

import '../widgets/collection_tile.dart';

class CollectionsView extends StatefulWidget {
  CollectionsView({Key? key}) : super(key: key);

  @override
  State<CollectionsView> createState() => _CollectionsViewState();
}

class _CollectionsViewState extends State<CollectionsView> {
  final TextEditingController nameController = TextEditingController();

  Future<void> showAddDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) =>
          Consumer<CollectionProvider>(builder: (context, viewModel, child) {
        if (viewModel.addCollectionState == TaskState.success) {
          Navigator.pop(context);
        }
        return AlertDialog(
            title: const Text("New Collection"),
            content: TextField(
              decoration: const InputDecoration(hintText: "Name"),
              controller: nameController,
            ),
            actions: changeDialogUI(viewModel));
      }),
    );
  }

  List<Widget> changeDialogUI(CollectionProvider viewModel) {
    if (viewModel.addCollectionState == TaskState.loading) {
      return [const CircularProgressIndicator()];
    } else if (viewModel.addCollectionState == TaskState.failure) {
      return [const Text("Failure")];
    } else {
      return [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error, 
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              viewModel.addCollection(name: nameController.text);
              nameController.clear();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text("Add"),
        )
      ];
    }
  }

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
        title: const Text("Note Warden"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<CollectionProvider>(
        builder: (context, viewModel, child) {
          if (viewModel.loadCollectionsState == TaskState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModel.loadCollectionsState == TaskState.success) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return CollectionTile(
                  collection: viewModel.collections[index],
                  onPressed: () => Navigator.pushNamed(context, '/collection',
                      arguments: viewModel.collections[index]),
                );
              },
              itemCount: viewModel.collections.length,
            );
          } else {
            return const Text("None");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddDialog(context),
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
