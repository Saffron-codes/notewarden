import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/core/presentation/dialog/confirmation_dialog.dart';
import 'package:note_warden/feature_collection/domain/model/collection_model.dart';
import 'package:note_warden/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';

class CollectionSheet extends StatelessWidget {
  final Collection collection;
  const CollectionSheet({super.key, required this.collection});

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
                    BlocProvider.of<CollectionsBloc>(context, listen: false)
                        .add(DeleteCollection(collection));
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
