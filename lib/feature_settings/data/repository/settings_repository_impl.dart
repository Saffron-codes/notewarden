import 'package:note_warden/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/feature_settings/data/data_source/settings_data_source.dart';
import 'package:note_warden/feature_settings/domain/model/app_settings.dart';
import 'package:note_warden/feature_settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource settingsDataSource;
  SettingsRepositoryImpl(this.settingsDataSource);
  @override
  AppSettings getAppSettings() {
    return settingsDataSource.getAppSettings();
  }

  @override
  void setCollectionOrder(CollectionOrder value) {
    settingsDataSource.setCollectionOrder(value);
  }

  @override
  void setReceiveBeta(bool value) {
    settingsDataSource.setReceiveBeta(value);
  }

  @override
  void setTheme(String value) {
    settingsDataSource.setTheme(value);
  }
}
