import 'package:flutter/material.dart';
import 'package:note_warden/constants.dart';
import 'package:note_warden/services/app_updater.dart';
import 'package:note_warden/services/cache_service.dart';
import 'package:note_warden/view/widgets/bottom_sheets/beta_updates_sheet.dart';

class AppUpdaterViewModel with ChangeNotifier {
  final CacheService cacheService;
  final AppUpdater appUpdater;

  AppUpdaterViewModel(this.cacheService, this.appUpdater);

  void showBottomSheetDialog(BuildContext context) {
    if (!(cacheService.isReceivingBeta() != null)) {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => BetaUpdatesSheet(cacheService),
      );
    } else {
      appUpdater.check(repo, cacheService.isReceivingBeta() ?? false, context);
    }
  }

  bool isReceivingBetaUpdates() {
    return cacheService.isReceivingBeta() ?? false;
  }
}
