import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_warden/providers/settings_provider.dart';
import 'package:note_warden/widgets/bottom_sheets/developer_story_sheet.dart';
import 'package:note_warden/widgets/dialogs/collections_order_dialog.dart';
import 'package:note_warden/widgets/dialogs/theme_dialog.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  Future<void> showThemeDialog(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => const ThemeDialog());
  }

  Future<void> showListOrderDialog(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => const CollectionsOrderDialog());
  }

  void showDeveloperStory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) => const DeveloperStorySheet(),
    );
  }

  static const channel = MethodChannel("com.notewarden");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Consumer<SettingsProvider>(builder: (context, viewModel, child) {
        return SettingsList(
          lightTheme: SettingsThemeData(
              settingsListBackground: Theme.of(context).colorScheme.background),
          sections: [
            SettingsSection(
              title: Text('User'),
              tiles: [
                SettingsTile(
                  leading: Icon(Icons.sort),
                  title: Text('List Order'),
                  value: Text(viewModel.getListOrder()),
                  onPressed: (context) => showListOrderDialog(context),
                ),
                SettingsTile(
                  leading: Icon(Icons.mail),
                  title: Text('Invite Friends'),
                  onPressed: (context) {
                    channel.invokeMethod("inviteFriends");
                  },
                ),
              ],
            ),
            SettingsSection(
              title: Text('Display'),
              tiles: [
                SettingsTile(
                  leading: Icon(Icons.brightness_6),
                  title: Text('Theme'),
                  value: Text(viewModel.themeMode.name),
                  onPressed: (context) => showThemeDialog(context),
                ),
              ],
            ),
            SettingsSection(
              title: Text('FeedBack'),
              tiles: [
                SettingsTile(
                  leading: Icon(Icons.bug_report),
                  title: Text('I Spotted a Bug'),
                  onPressed: (context) => Navigator.pushNamed(context, "/report",arguments: "Bug"),
                ),
                SettingsTile(
                  leading: Icon(Icons.settings_suggest),
                  title: Text('I Have a Suggestion'),
                  onPressed: (context) => Navigator.pushNamed(context, "/report",arguments: "Suggestion"),
                ),
              ],
            ),
            SettingsSection(
              title: Text("About"),
              tiles: [
                SettingsTile(
                  leading: Icon(Icons.developer_mode_rounded),
                  title: Text('Developer'),
                  onPressed: (context) {
                    showDeveloperStory(context);
                  },
                ),
                SettingsTile(
                  leading: Icon(Icons.info),
                  title: Text('Software Licenses'),
                  onPressed: (context) {
                    showLicensePage(context: context);
                  },
                ),
                SettingsTile(
                  leading: Icon(Icons.build_circle),
                  title: Text('Build version'),
                  value: Text(viewModel.buildVersion),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
