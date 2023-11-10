import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
import 'package:note_warden/features/feature_settings/presentation/settings_cubit/settings_cubit.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;
import '../../../domain/util/collection_order.dart';

class CommandBarButtonWithMenu extends CommandBarItem {
  CommandBarButtonWithMenu({super.key});

  final menuController = FlyoutController();

  @override
  Widget build(BuildContext context, CommandBarItemDisplayMode displayMode) {
    final settingsBloc = BlocProvider.of<SettingsCubit>(context, listen: false);

    assert(debugCheckHasFluentTheme(context));
    return FlyoutTarget(
      controller: menuController,
      child: IconButton(
        key: key,
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
                  text: const Text("Date Created"),
                  leading: const Icon(fi.FluentIcons.calendar_add_24_regular),
                  selected: settingsBloc.state.collectionOrder ==
                      CollectionOrder.byCreation,
                  onPressed: () {
                    settingsBloc.setCollectionOrder(CollectionOrder.byCreation);
                    BlocProvider.of<CollectionsBloc>(context, listen: false)
                        .add(ToggleOrder(CollectionOrder.byCreation));
                    Flyout.of(context1).close();
                  },
                ),
                // const MenuFlyoutSeparator(),
                MenuFlyoutItem(
                  text: const Text("Date Modified"),
                  leading: const Icon(fi.FluentIcons.calendar_edit_24_regular),
                  selected: settingsBloc.state.collectionOrder ==
                      CollectionOrder.byModification,
                  onPressed: () {
                    settingsBloc
                        .setCollectionOrder(CollectionOrder.byModification);
                    BlocProvider.of<CollectionsBloc>(context, listen: false)
                        .add(ToggleOrder(CollectionOrder.byModification));
                    Flyout.of(context1).close();
                  },
                ),
              ]);
            },
          );
        },
        style: ButtonStyle(
          backgroundColor: ButtonState.resolveWith((states) {
            final theme = FluentTheme.of(context);
            return ButtonThemeData.uncheckedInputColor(
              theme,
              states,
              transparentWhenNone: true,
            );
          }),
        ),
        icon: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              // data: const IconThemeData(size: 16),
              fi.FluentIcons.arrow_sort_28_regular,
            ),
            SizedBox(width: 10),
            Text("Sort by")
          ],
        ),
      ),
    );
  }
}
