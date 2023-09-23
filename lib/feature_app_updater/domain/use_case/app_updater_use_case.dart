import 'package:note_warden/feature_app_updater/domain/use_case/check_is_receiving_beta.dart';
import 'package:note_warden/feature_app_updater/domain/use_case/check_update.dart';
import 'package:note_warden/feature_app_updater/domain/use_case/download_apk.dart';

class AppUpdaterUseCase {
  final CheckIsReceivingBeta checkIsReceivingBeta;
  final CheckUpdate checkUpdate;
  final DownloadAPK downloadAPK;

  const AppUpdaterUseCase(
    this.checkIsReceivingBeta,
    this.checkUpdate,
    this.downloadAPK,
  );
}
