import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onPressedOK;
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedOK,
  });

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FilledButton(
          onPressed: onPressedOK,
          child: const Text("Delete"),
        ),
        Button(
          onPressed: () {
            context.pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
