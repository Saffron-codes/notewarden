import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';

class AddCollectionDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  AddCollectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Collection"),
      content: TextField(
        decoration: const InputDecoration(hintText: "Name"),
        controller: controller,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<CollectionsBloc>(context)
                .add(AddCollection(controller.text));
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text("Add"),
        )
      ],
    );
  }
}
