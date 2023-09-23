import 'package:note_warden/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/feature_settings/domain/model/app_settings.dart';

abstract class SettingsRepository {
  void setTheme(String value);
  void setCollectionOrder(CollectionOrder value);
  void setReceiveBeta(bool value);

  AppSettings getAppSettings();
}
