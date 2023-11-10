import 'package:note_warden/features/feature_app_updater/domain/model/app_update_info.dart';
import 'package:note_warden/features/feature_app_updater/domain/repository/app_updater_repository.dart';

class CheckUpdate {
  final AppUpdaterRepository appUpdaterRepository;

  const CheckUpdate(this.appUpdaterRepository);

  Future<AppUpdateInfo> invoke() async {
    return appUpdaterRepository.check();
  }
}
