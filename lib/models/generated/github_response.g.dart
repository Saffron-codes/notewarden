// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../github_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubResponse _$GithubResponseFromJson(Map<String, dynamic> json) =>
    GithubResponse(
      htmlUrl: json['html_url'] as String,
      tagName: json['tag_name'] as String,
      prerelease: json['prerelease'] as bool,
      createdAt: json['created_at'] as String,
      body: json['body'] as String?,
      assets: (json['assets'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GithubResponseToJson(GithubResponse instance) =>
    <String, dynamic>{
      'html_url': instance.htmlUrl,
      'tag_name': instance.tagName,
      'prerelease': instance.prerelease,
      'created_at': instance.createdAt,
      'body': instance.body,
      'assets': instance.assets,
    };
