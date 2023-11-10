// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isBug: json['isBug'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      buildVersion: json['build_version'] as String,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'build_version': instance.buildVersion,
      'isBug': instance.isBug,
      'createdAt': instance.createdAt.toIso8601String(),
    };
