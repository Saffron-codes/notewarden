import 'package:note_warden/features/feature_report/domain/repository/report_repository.dart';

class SubmitReport {
  final ReportRepository reportRepository;

  SubmitReport(this.reportRepository);

  Future<void> invoke(String title, String description, bool isBug) async {
    return reportRepository.submitReport(title, description, isBug);
  }
}
