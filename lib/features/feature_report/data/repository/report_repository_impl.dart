import 'package:note_warden/features/feature_report/data/data_source/report_data_source.dart';
import 'package:note_warden/features/feature_report/domain/repository/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportDataSource reportDataSource;

  ReportRepositoryImpl(this.reportDataSource);
  @override
  Future<void> submitReport(String title, String description, bool isBug) {
    return reportDataSource.submitReport(title, description, isBug);
  }
}
