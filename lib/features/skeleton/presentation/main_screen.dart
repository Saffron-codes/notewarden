import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:note_warden/router.dart';
import 'package:window_manager/window_manager.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  final BuildContext? shellContext;
  const MainScreen(
      {super.key, required this.child, required this.shellContext});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WindowListener {
  int topIndex = 0;
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  bool canPop = true;

  late final List<NavigationPaneItem> items = [
    PaneItem(
      key: const ValueKey('/'),
      icon: const Icon(fi.FluentIcons.home_24_regular),
      title: const Text('Home'),
      body: const SizedBox.shrink(),
      onTap: () {
        final path = '/';
        if (GoRouterState.of(context).uri.toString() != path) {
          context.go(path);
        }
      },
    ),
  ];
  // paneItems
  // late final List<NavigationPaneItem> items = [
  //   PaneItem(
  //     key: const ValueKey('/'),
  //     icon: const Icon(FluentIcons.home),
  //     title: const Text('Home'),
  //     body: const SizedBox.shrink(),
  //   ),
  //   PaneItemSeparator(),
  //   // PaneItem(
  //   //   key: const ValueKey('/collection/new'),
  //   //   icon: const Icon(FluentIcons.add),
  //   //   title: const Text('Add Collection'),
  //   //   body: const SizedBox.shrink(),
  //   // ),
  // ].map((e) {
  //   if (e is PaneItem) {
  //     return PaneItem(
  //       key: e.key,
  //       icon: e.icon,
  //       title: e.title,
  //       body: e.body,
  //       onTap: () {
  //         final path = (e.key as ValueKey).value;
  //         if (GoRouterState.of(context).uri.toString() != path) {
  //           context.go(path);
  //         }
  //         e.onTap?.call();
  //       },
  //     );
  //   }
  //   return e;
  // }).toList();

  late final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: ValueKey("/settings"),
      icon: const Icon(fi.FluentIcons.settings_24_regular),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/settings') {
          context.go('/settings');
        }
      },
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal = items
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(location));
    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return items.where((element) => element.key != null).toList().length +
          indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.backspace) &&
              context.canPop()) {
            context.pop();
          }
        }
      },
      child: NavigationView(
        key: viewKey,
        appBar: NavigationAppBar(
          title: Text("NoteWarden"),
          leading: IconButton(
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(fi.FluentIcons.arrow_left_24_regular),
            ),
            onPressed: () {
              if (router.canPop()) {
                router.pop();
              }
            },
          ),
        ),
        paneBodyBuilder: (item, body) {
          final name =
              item?.key is ValueKey ? (item!.key as ValueKey).value : null;
          return FocusTraversalGroup(
            key: ValueKey('body$name'),
            child: widget.child,
          );
        },
        pane: NavigationPane(
          items: items,
          selected: _calculateSelectedIndex(context),
          footerItems: footerItems,
          displayMode: PaneDisplayMode.compact,
          size: const NavigationPaneSize(openMaxWidth: 150),
        ),
      ),
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
