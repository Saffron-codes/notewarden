import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/features/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/features/feature_settings/presentation/settings_cubit/settings_cubit.dart';
import 'package:note_warden/features/feature_settings/presentation/settings_cubit/settings_state.dart';
import 'package:note_warden/features/feature_settings/presentation/widgets/settings_group.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsCubit =
        BlocProvider.of<SettingsCubit>(context, listen: false);

    return BlocBuilder<SettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return ScaffoldPage.scrollable(
          children: [
            SettingsGroup(
              groupName: "User",
              items: [
                SettingsItem<CollectionOrder>(
                  subtitle: "Collection Order",
                  description: "Choose the order based on time",
                  icon: Icon(fi.FluentIcons.arrow_sort_24_regular),
                  options: [
                    SettingOption(
                      value: CollectionOrder.byCreation,
                      text: "Date Created",
                    ),
                    SettingOption(
                      value: CollectionOrder.byModification,
                      text: "Date Modified",
                    ),
                  ],
                  selectedOption: state.collectionOrder,
                  onOptionChanged: (val) {
                    settingsCubit.setCollectionOrder(val!);
                  },
                )
              ],
            ),
            SettingsGroup(
              groupName: "Display",
              items: [
                SettingsItem<ThemeMode>(
                  subtitle: "Theme",
                  description: "Choose the colors that appear in the app",
                  icon: Icon(FluentIcons.color),
                  options: [
                    SettingOption(value: ThemeMode.system, text: "Auto"),
                    SettingOption(value: ThemeMode.light, text: "Light"),
                    SettingOption(value: ThemeMode.dark, text: "Dark"),
                  ],
                  selectedOption: state.themeMode,
                  onOptionChanged: (val) {
                    settingsCubit.setTheme(val!);
                  },
                )
              ],
            ),
            SettingsGroup(
              groupName: "About",
              items: [
                SettingsItem(
                  subtitle: "Visit Website",
                  description: "notewarden.netlify.app",
                  icon: const Icon(fi.FluentIcons.web_asset_24_regular),
                  isMenu: false,
                  trailing: IconButton(
                    icon: const Icon(
                      fi.FluentIcons.open_24_regular,
                      size: 18,
                    ),
                    // iconButtonMode: IconButtonMode.large,
                    onPressed: () {
                      launchUrl(Uri.parse("https://notewarden.netlify.app"));
                    },
                  ),
                ),
                SettingsItem(
                  subtitle: "NoteWarden ${state.buildVersion}",
                  description: "Developed with love by Saffron Dionysius",
                  icon: const Icon(fi.FluentIcons.info_24_regular),
                  isMenu: false,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
