import 'package:flutter/material.dart';
import 'package:note_warden/feature_collection/domain/util/collection_order.dart';

class AppSettingsState {
  final ThemeMode themeMode;
  final CollectionOrder collectionOrder;
  final bool isReceivingBeta;
  final String buildVersion;

  const AppSettingsState(
    this.themeMode,
    this.collectionOrder,
    this.isReceivingBeta,
    this.buildVersion,
  );

  AppSettingsState copyWith({
    ThemeMode? themeMode,
    CollectionOrder? collectionOrder,
    bool? isReceivingBeta,
  }) =>
      AppSettingsState(
        themeMode ?? this.themeMode,
        collectionOrder ?? this.collectionOrder,
        isReceivingBeta ?? this.isReceivingBeta,
        buildVersion,
      );
}
