import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/widgets/collection_card.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/widgets/collection_list_shimmer.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/widgets/empty_list_guide.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;

import 'dialog/add_collection_dialog.dart';
import 'widgets/commandbar_button_with_menu.dart';

class CollectionScreen extends StatelessWidget {
  CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
          title: const Text("Collections"),
          commandBar: CommandBar(
            mainAxisAlignment: MainAxisAlignment.end,
            primaryItems: [
              CommandBarBuilderItem(
                builder: (context, mode, w) => Tooltip(
                  message: "Create something new!",
                  child: w,
                ),
                wrappedItem: CommandBarButton(
                  icon: const Icon(fi.FluentIcons.add_24_regular),
                  label: const Text('New'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddCollectionDialog(),
                    );
                  },
                ),
              ),
              const CommandBarSeparator(),
              CommandBarBuilderItem(
                builder: (context, mode, w) => Tooltip(
                  message: "Sort Collections",
                  child: w,
                ),
                // wrappedItem: CommandBarButtonWithMenu()
                wrappedItem: CommandBarButtonWithMenu(),
              ),
            ],
          ),
        ),
        content: BlocBuilder<CollectionsBloc, CollectionsState>(
          builder: (context, state) {
            if (state is CollectionsLoaded) {
              return state.collections.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.separated(
                          itemCount: state.collections.length,
                          itemBuilder: (_, i) =>
                              CollectionCard(collection: state.collections[i]),
                          separatorBuilder: (_, i) => const SizedBox(
                            height: 10,
                          ),
                        ),
                      ),
                    )
                  : const EmptyListGuide(
                      isForCollection: true,
                    );
            } else if (state is CollectionsLoading) {
              return const CollectionListShimmer();
            } else {
              return const CollectionListShimmer();
            }
          },
        ));
  }
}

//  Row(
//           children: [
//             SizedBox(
//               width: 50,
//             ),
//             Text(
//               "Your Collections",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//             ),
//             Spacer(),
//             IconButton(
//               icon: Icon(FluentIcons.add),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AddCollectionDialog(),
//                 );
//               },
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             DropDownButton(
//               title: Text("Sort by"),
//               placement: FlyoutPlacementMode.bottomRight,
//               items: [
//                 MenuFlyoutItem(
//                   text: Text("Date Created"),
//                   leading: Icon(FluentIcons.add_event),
//                   onPressed: () {},
//                 ),
//                 MenuFlyoutItem(
//                   text: Text("Date Modified"),
//                   leading: Icon(FluentIcons.edit_event),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//             SizedBox(
//               width: 50,
//             )
//           ],
//         ),


