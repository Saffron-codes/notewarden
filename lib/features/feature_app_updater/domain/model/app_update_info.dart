import 'package:json_annotation/json_annotation.dart';
part 'app_update_info.g.dart';

@JsonSerializable()
class AppUpdateInfo {
  @JsonKey(name: "version")
  final String version;

  @JsonKey(name: "md")
  final String md;

  @JsonKey(name: "current_version")
  final String currentVersion;

  @JsonKey(name: "is_new_version")
  final bool updateAvailable;

  const AppUpdateInfo(
      this.version, this.md, this.currentVersion, this.updateAvailable);

  factory AppUpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppUpdateInfoToJson(this);
}
