import 'package:note_warden/features/feature_settings/domain/model/app_settings.dart';
import 'package:note_warden/features/feature_settings/domain/repository/settings_repository.dart';

class GetAppSettings {
  final SettingsRepository settingsRepository;

  const GetAppSettings(this.settingsRepository);

  AppSettings invoke() {
    return settingsRepository.getAppSettings();
  }
}
