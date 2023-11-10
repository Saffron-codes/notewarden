import 'package:note_warden/features/feature_app_updater/domain/model/app_update_info.dart';

abstract class AppUpdaterRepository {
  Future<AppUpdateInfo> check();
  void downloadAPK();
  bool? isReceivingBeta();
}
