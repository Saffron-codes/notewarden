import 'package:flutter/material.dart';
import 'package:note_warden/models/collection_model.dart';
import 'package:note_warden/view/providers/collection_provider.dart';
import 'package:note_warden/view/widgets/dialogs/confirmation_dialog.dart';
import 'package:provider/provider.dart';

class CollectionOptionsSheet extends StatelessWidget {
  final Collection collection;
  const CollectionOptionsSheet({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 20),
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
            onTap: () {
              // Navigator.of(context).pop(true);
              showDialog(
                context: context,
                builder: (_) => ConfirmationDialog(
                  title: 'Delete Collection',
                  content: 'All Media will be deleted',
                  onPressedOK: () {
                    Provider.of<CollectionProvider>(context,listen: false).deleteCollection(collection);
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop(true);
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Cancel'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
