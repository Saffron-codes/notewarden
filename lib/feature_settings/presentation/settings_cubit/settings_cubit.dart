import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:note_warden/feature_collection/domain/util/collection_order.dart';
import 'package:note_warden/feature_settings/domain/use_case/settings_use_case.dart';
import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsCubit extends Cubit<AppSettingsState> {
  final SettingsUseCase settingsUseCase;
  final PackageInfo packageInfo;

  SettingsCubit(this.settingsUseCase, this.packageInfo)
      : super(const AppSettingsState(
            ThemeMode.system, CollectionOrder.byCreation, false, "")) {
    loadAppSettings();
  }

  // AppSettings settings =
  //     AppSettings("system", CollectionOrder.byCreation, false);
  void loadAppSettings() {
    final settings = settingsUseCase.getAppSettings.invoke();
    final buildVersion = packageInfo.version;
    final settingsState = AppSettingsState(getTheme(settings.theme),
        settings.collectionOrder, settings.isReceivingBeta, buildVersion);
    emit(settingsState);
  }

  void setTheme(ThemeMode themeMode) {
    settingsUseCase.setAppSettings.setTheme(themeMode.name);
    final settingsState = state.copyWith(themeMode: themeMode);
    emit(settingsState);
  }

  void setCollectionOrder(CollectionOrder collectionOrder) {
    settingsUseCase.setAppSettings.setCollectionOrder(collectionOrder);
    final settingsState = state.copyWith(collectionOrder: collectionOrder);
    emit(settingsState);
  }

  void setIsReceivingBeta(bool val) {
    settingsUseCase.setAppSettings.setReceiveBetaUpdates(val);
    final settingsState = state.copyWith(isReceivingBeta: val);
    emit(settingsState);
  }

  ThemeMode getTheme(String theme) {
    if (theme == "system") {
      return ThemeMode.system;
    } else if (theme == "light") {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }
}
