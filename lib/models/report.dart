import 'package:json_annotation/json_annotation.dart';
part 'generated/report.g.dart';

@JsonSerializable()
class Report {
  final String id,title,description;
  @JsonKey(name: "build_version")
  final String buildVersion;
  final bool isBug;

  final DateTime createdAt;

  Report({required this.id,required this.title,required this.description,required this.isBug,required this.createdAt,required this.buildVersion});


  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);


  Map<String, dynamic> toJson() => _$ReportToJson(this);
}