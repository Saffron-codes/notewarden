import 'package:flutter/material.dart';
import 'package:note_warden/providers/collection_provider.dart';
import 'package:provider/provider.dart';

import '../models/collection_model.dart';

class CollectionDetailedView extends StatefulWidget {
  const CollectionDetailedView({super.key});

  @override
  State<CollectionDetailedView> createState() => _CollectionDetailedViewState();
}

class _CollectionDetailedViewState extends State<CollectionDetailedView> {

  Collection? collection;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CollectionProvider>(context, listen: false)
          .loadMediaCount(collectionId: collection!.id);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final col = ModalRoute.of(context)!.settings.arguments as Collection;
    collection = col;
  }

  @override
  Widget build(BuildContext context) {
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(collection.name),
        actions: [
          Consumer<CollectionProvider>(
            builder: (context, viewModel, child) {
              return Text(viewModel.mediaCount.toString());
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add_a_photo_rounded,
        ),
      ),
    );
  }
}
