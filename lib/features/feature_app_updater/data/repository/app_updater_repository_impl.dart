import 'package:note_warden/features/feature_app_updater/data/data_source/app_updater_data_source.dart';
import 'package:note_warden/features/feature_app_updater/domain/model/app_update_info.dart';
import 'package:note_warden/features/feature_app_updater/domain/repository/app_updater_repository.dart';

class AppUpdaterRepositoryImpl implements AppUpdaterRepository {
  final AppUpdaterDataSource appUpdaterDataSource;

  AppUpdaterRepositoryImpl(this.appUpdaterDataSource);

  @override
  Future<AppUpdateInfo> check() async {
    return await appUpdaterDataSource.checkForUpdates();
  }

  @override
  void downloadAPK() {
    return appUpdaterDataSource.downloadAPK();
  }

  @override
  bool? isReceivingBeta() {
    return appUpdaterDataSource.isReceivingBeta();
  }
}
