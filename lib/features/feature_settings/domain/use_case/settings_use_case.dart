import 'package:note_warden/features/feature_settings/domain/use_case/get_app_settings.dart';
import 'package:note_warden/features/feature_settings/domain/use_case/set_app_settings.dart';

class SettingsUseCase {
  final GetAppSettings getAppSettings;
  final SetAppSettings setAppSettings;

  const SettingsUseCase(this.getAppSettings, this.setAppSettings);
}
