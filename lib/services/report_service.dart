import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_warden/models/report.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ReportService {
  final FirebaseFirestore firestore;
  final PackageInfo packageInfo;

  const ReportService({required this.firestore,required this.packageInfo});

  void submitReport(String title,String description,bool isBug)async {
    try {
      final report = Report(id: '', title: title, description: description, isBug: isBug, createdAt: DateTime.now(), buildVersion: packageInfo.version);
      final doc = await firestore.collection("reports")
        .add(
          report.toJson()
        );
      await doc.update({'id':doc.id});
    } catch (e) {
      throw Exception("Report Error");
    }
  }
}
