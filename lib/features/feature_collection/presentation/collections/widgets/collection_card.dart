import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_warden/core/presentation/dialog/confirmation_dialog.dart';
import 'package:note_warden/core/presentation/util/date_utils.dart';
import 'package:note_warden/features/feature_collection/domain/model/collection_model.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;

import '../../../domain/util/collection_order.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  const CollectionCard({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    final menuController = FlyoutController();
    final state = BlocProvider.of<CollectionsBloc>(context).state;
    return Card(
      padding: EdgeInsets.zero,
      child: ListTile(
        onPressed: () => context.pushNamed("media", extra: collection),
        subtitle: state is CollectionsLoaded
            ? state.collectionOrder == CollectionOrder.byCreation
                ? Text(formatDate(collection.createdAt))
                : Text(formatDate(collection.updatedAt))
            : Container(),
        title: Text(collection.name),
        trailing: FlyoutTarget(
            controller: menuController,
            child: IconButton(
              icon: const Icon(fi.FluentIcons.more_horizontal_28_regular),
              onPressed: () {
                menuController.showFlyout(
                  autoModeConfiguration: FlyoutAutoConfiguration(
                    preferredMode: FlyoutPlacementMode.bottomRight,
                  ),
                  barrierDismissible: true,
                  dismissOnPointerMoveAway: false,
                  dismissWithEsc: true,
                  barrierColor: Colors.transparent,
                  builder: (context1) {
                    return MenuFlyout(items: [
                      MenuFlyoutItem(
                        leading:
                            const Icon(fi.FluentIcons.folder_open_24_regular),
                        text: const Text('Open'),
                        onPressed: () {
                          context.pushNamed("media", extra: collection);
                          Flyout.of(context1).close();
                        },
                      ),
                      const MenuFlyoutSeparator(),
                      MenuFlyoutItem(
                        leading: const Icon(fi.FluentIcons.delete_24_regular),
                        text: const Text('Delete'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              title: 'Delete Collection',
                              content: 'All Media will be deleted',
                              onPressedOK: () {
                                BlocProvider.of<CollectionsBloc>(context,
                                        listen: false)
                                    .add(DeleteCollection(collection));
                                context.pop();
                              },
                            ),
                          );
                          Flyout.of(context1).close();
                        },
                      ),
                    ]);
                  },
                );
              },
            )),
      ),
    );
  }
}
