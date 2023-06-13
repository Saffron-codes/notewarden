import 'package:flutter/material.dart';
import 'package:note_warden/models/collection_model.dart';

import '../utils/convert_to_ago.dart';

class CollectionTile extends StatelessWidget {
  final Collection collection;
  final Function() onPressed;
  const CollectionTile({super.key,required this.collection,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Card(
          child: ListTile(
            title: Row(
              children: [
                Expanded(child: Text(collection.name),),
                Text(formatDateTimeAgo(collection.createdAt),style: const TextStyle(fontSize: 10)),
              ],
            ),
            // subtitle: Text("10 Notes"),
            onTap:onPressed,
          ),
        ),
      );
  }
}