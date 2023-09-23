import 'package:note_warden/feature_app_updater/domain/repository/app_updater_repository.dart';

class DownloadAPK {
  final AppUpdaterRepository appUpdaterRepository;

  const DownloadAPK(this.appUpdaterRepository);

  void invoke() {
    return appUpdaterRepository.downloadAPK();
  }
}
