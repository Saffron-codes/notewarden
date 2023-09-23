import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_settings/presentation/bottom_sheet/developer_story_sheet.dart';
import 'package:note_warden/feature_settings/presentation/dialog/collection_order_dialog.dart';
import 'package:note_warden/feature_settings/presentation/dialog/theme_dialog.dart';
import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_cubit.dart';
import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_state.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: BlocBuilder<SettingsCubit, AppSettingsState>(
        builder: (context, state) {
          return SettingsList(
            lightTheme: SettingsThemeData(
                settingsListBackground:
                    Theme.of(context).colorScheme.background),
            sections: [
              SettingsSection(
                title: Text('User'),
                tiles: [
                  SettingsTile(
                    leading: Icon(Icons.sort),
                    title: Text('List Order'),
                    value: Text(state.collectionOrder.name),
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
                    value: Text(state.themeMode.name),
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
                    onPressed: (context) => Navigator.pushNamed(
                        context, "/report",
                        arguments: "Bug"),
                  ),
                  SettingsTile(
                    leading: Icon(Icons.settings_suggest),
                    title: Text('I Have a Suggestion'),
                    onPressed: (context) => Navigator.pushNamed(
                        context, "/report",
                        arguments: "Suggestion"),
                  ),
                ],
              ),
              SettingsSection(
                title: Text("About"),
                tiles: [
                  SettingsTile.switchTile(
                    initialValue: state.isReceivingBeta,
                    onToggle: (val) {
                      BlocProvider.of<SettingsCubit>(context, listen: false)
                          .setIsReceivingBeta(val);
                    },
                    leading: Icon(Icons.new_releases),
                    title: Text("Receive Beta updates"),
                    description: Text("Beta builds from Github"),
                  ),
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
                    leading: Icon(Icons.web),
                    title: Text('Visit Website'),
                    value: Text("notewarden.netlify.app"),
                    onPressed: (context) {
                      launchUrl(Uri.parse("https://notewarden.netlify.app"));
                    },
                  ),
                  SettingsTile(
                    leading: Icon(Icons.build_circle),
                    title: Text('Build version'),
                    value: Text(state.buildVersion),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
