import 'package:note_warden/features/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/features/feature_settings/domain/repository/settings_repository.dart';

class SetAppSettings {
  final SettingsRepository settingsRepository;
  const SetAppSettings(this.settingsRepository);

  void setTheme(String val) {
    settingsRepository.setTheme(val);
  }

  void setCollectionOrder(CollectionOrder order) {
    settingsRepository.setCollectionOrder(order);
  }

  void setReceiveBetaUpdates(bool val) {
    settingsRepository.setReceiveBeta(val);
  }
}
