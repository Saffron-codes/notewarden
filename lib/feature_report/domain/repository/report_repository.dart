abstract class ReportRepository {
  Future<void> submitReport(String title, String description, bool isBug);
}
