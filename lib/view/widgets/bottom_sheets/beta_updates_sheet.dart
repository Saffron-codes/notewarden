import 'package:flutter/material.dart';
import 'package:note_warden/services/cache_service.dart';

class BetaUpdatesSheet extends StatelessWidget {
  final CacheService cacheService;
  const BetaUpdatesSheet(this.cacheService,{super.key});

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
                  cacheService.setBetaUpdatesOption(true);
                  Navigator.pop(context, true);
                },
                child: const Text('Yes'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  cacheService.setBetaUpdatesOption(false);
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
