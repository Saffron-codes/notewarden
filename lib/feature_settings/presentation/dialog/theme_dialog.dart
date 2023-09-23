import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_cubit.dart';
import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_state.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsCubit>(context, listen: false);

    return AlertDialog(
      title: const Text("Choose theme"),
      content: BlocBuilder<SettingsCubit, AppSettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: const Text("System Default"),
                value: ThemeMode.system,
                groupValue: state.themeMode,
                onChanged: (val) => settingsBloc.setTheme(val!),
              ),
              RadioListTile<ThemeMode>(
                title: const Text("Light"),
                value: ThemeMode.light,
                groupValue: state.themeMode,
                onChanged: (val) => settingsBloc.setTheme(val!),
              ),
              RadioListTile<ThemeMode>(
                title: const Text("Dark"),
                value: ThemeMode.dark,
                groupValue: state.themeMode,
                onChanged: (val) => settingsBloc.setTheme(val!),
              ),
            ],
          );
        },
      ),
    );
  }
}
