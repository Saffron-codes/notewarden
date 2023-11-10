import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';

class AddCollectionDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  AddCollectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text("New Collection"),
      content: TextBox(
        autofocus: true,
        placeholder: "Name",
        controller: controller,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            BlocProvider.of<CollectionsBloc>(context)
                .add(AddCollection(controller.text));
            context.pop();
          }
        },
      ),
      actions: [
        FilledButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              BlocProvider.of<CollectionsBloc>(context)
                  .add(AddCollection(controller.text));
              Navigator.pop(context);
            }
          },
          child: const Text("Add"),
        ),
        Button(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
