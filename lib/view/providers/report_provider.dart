import 'package:flutter/foundation.dart';
import 'package:note_warden/services/report_service.dart';
import 'package:note_warden/utils/enums.dart';


class ReportProvider with ChangeNotifier {
  final ReportService reportService;

  ReportProvider({required this.reportService});

  TaskState _reportUploadTaskState = TaskState.none;

  TaskState get reportUploadTaskState => _reportUploadTaskState;

  void uploadReport(String title,String description,bool isBug) async {
    try {
      _reportUploadTaskState = TaskState.loading;
      notifyListeners();
      reportService.submitReport(title,description,isBug);
      _reportUploadTaskState = TaskState.success;
      notifyListeners();
    } catch (e) {
      _reportUploadTaskState = TaskState.failure;
      notifyListeners();
    }
  }
}
