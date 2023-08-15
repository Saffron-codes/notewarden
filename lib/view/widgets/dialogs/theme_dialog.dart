import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/settings_provider.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Choose theme"),
      content: Consumer<SettingsProvider>(builder: (context, viewModel, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text("System Default"),
              value: ThemeMode.system,
              groupValue: viewModel.themeMode,
              onChanged: (val) => viewModel.themeMode = val!,
            ),
            RadioListTile<ThemeMode>(
              title: const Text("Light"),
              value: ThemeMode.light,
              groupValue:  viewModel.themeMode,
              onChanged: (val) => viewModel.themeMode = val!,
            ),
            RadioListTile<ThemeMode>(
              title: const Text("Dark"),
              value: ThemeMode.dark,
              groupValue:  viewModel.themeMode,
              onChanged: (val)=> viewModel.themeMode = val!,
            ),
          ],
        );
      }),
    );
  }
}
