import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_cubit.dart';

class CollectionsOrderDialog extends StatelessWidget {
  const CollectionsOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsCubit>(context, listen: false);

    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text("By time of creation"),
          onTap: () {
            settingsBloc.setCollectionOrder(CollectionOrder.byCreation);
            BlocProvider.of<CollectionsBloc>(context, listen: false)
                .add(ToggleOrder(CollectionOrder.byCreation));
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text("By time of modifications"),
          onTap: () {
            settingsBloc.setCollectionOrder(CollectionOrder.byModification);
            BlocProvider.of<CollectionsBloc>(context, listen: false)
                .add(ToggleOrder(CollectionOrder.byModification));
            Navigator.pop(context);
          },
        )
      ],
    ));
  }
}
