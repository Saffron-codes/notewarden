import 'package:json_annotation/json_annotation.dart';

import 'asset.dart';

part 'generated/github_response.g.dart';

@JsonSerializable()
class GithubResponse {
  @JsonKey(name: 'html_url')
  final String htmlUrl;

  @JsonKey(name: 'tag_name')
  final String tagName;

  final bool prerelease;

  @JsonKey(name: 'created_at')
  final String createdAt;

  final String? body;

  final List<Asset>? assets;

  GithubResponse({
    required this.htmlUrl,
    required this.tagName,
    required this.prerelease,
    required this.createdAt,
    this.body,
    this.assets,
  });

  factory GithubResponse.fromJson(Map<String, dynamic> json) =>
      _$GithubResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GithubResponseToJson(this);

  int timeStamp() {
    return DateTime.parse(createdAt).millisecondsSinceEpoch;
  }
}