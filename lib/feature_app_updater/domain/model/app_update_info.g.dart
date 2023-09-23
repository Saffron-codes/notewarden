// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateInfo _$AppUpdateInfoFromJson(Map<String, dynamic> json) =>
    AppUpdateInfo(
      json['version'] as String,
      json['md'] as String,
      json['current_version'] as String,
      json['is_new_version'] as bool,
    );

Map<String, dynamic> _$AppUpdateInfoToJson(AppUpdateInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
      'md': instance.md,
      'current_version': instance.currentVersion,
      'is_new_version': instance.updateAvailable,
    };
