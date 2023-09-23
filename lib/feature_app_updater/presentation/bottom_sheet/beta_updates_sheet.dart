import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_cubit.dart';

class BetaUpdatesSheet extends StatelessWidget {
  const BetaUpdatesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Beta Updates',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Do you want to receive beta updates?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SettingsCubit>(context, listen: false)
                      .setIsReceivingBeta(true);
                  Navigator.pop(context, true);
                },
                child: const Text('Yes'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SettingsCubit>(context, listen: false)
                      .setIsReceivingBeta(false);
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
