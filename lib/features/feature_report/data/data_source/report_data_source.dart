import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_warden/features/feature_report/domain/model/report.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class ReportDataSource {
  Future<void> submitReport(String title, String description, bool isBug);
}

class ReportDataSourceImpl implements ReportDataSource {
  final FirebaseFirestore firestore;
  final PackageInfo packageInfo;

  ReportDataSourceImpl(this.firestore, this.packageInfo);
  @override
  Future<void> submitReport(
    String title,
    String description,
    bool isBug,
  ) async {
    try {
      final report = Report(
          id: '',
          title: title,
          description: description,
          isBug: isBug,
          createdAt: DateTime.now(),
          buildVersion: packageInfo.version);
      final doc = await firestore.collection("reports").add(report.toJson());
      await doc.update({'id': doc.id});
      return;
    } catch (e) {
      throw Exception("Report Error");
    }
  }
}
