import 'package:note_warden/features/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/features/feature_settings/domain/model/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsDataSource {
  void setTheme(String value);
  void setCollectionOrder(CollectionOrder value);
  void setReceiveBeta(bool value);

  AppSettings getAppSettings();
}

class SettingsDataSourceImpl implements SettingsDataSource {
  final SharedPreferences sharedPreferences;
  SettingsDataSourceImpl(this.sharedPreferences);
  @override
  AppSettings getAppSettings() {
    final theme = sharedPreferences.getString("theme") ?? "light";
    final collectionOrder =
        sharedPreferences.getString("listorder") == "byCreation"
            ? CollectionOrder.byCreation
            : CollectionOrder.byModification;
    final receiveBeta = sharedPreferences.getBool("beta_updates") ?? false;

    return AppSettings(theme, collectionOrder, receiveBeta);
  }

  @override
  void setCollectionOrder(CollectionOrder value) async {
    await sharedPreferences.setString("listorder", value.name);
  }

  @override
  void setReceiveBeta(bool value) async {
    await sharedPreferences.setBool("beta_updates", value);
  }

  @override
  void setTheme(String value) async {
    await sharedPreferences.setString("theme", value);
  }
}
