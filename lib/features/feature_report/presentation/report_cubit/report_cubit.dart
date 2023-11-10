import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/features/feature_report/domain/use_case/submit_report.dart';

class ReportCubit extends Cubit<bool> {
  final SubmitReport submitReportUseCase;
  ReportCubit(this.submitReportUseCase) : super(false);

  bool isLoading = false;
  void submitReport(String title, String description, bool isBug) async {
    emit(true);
    await submitReportUseCase.invoke(title, description, isBug);
    emit(false);
  }
}
