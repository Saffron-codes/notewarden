import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_warden/features/feature_app_updater/domain/model/app_update_info.dart';
import 'package:note_warden/features/feature_app_updater/domain/use_case/app_updater_use_case.dart';

part 'app_updater_event.dart';
part 'app_updater_state.dart';

class AppUpdaterBloc extends Bloc<AppUpdaterEvent, AppUpdaterState> {
  final AppUpdaterUseCase appUpdaterUseCase;
  AppUpdaterBloc(this.appUpdaterUseCase) : super(AppUpdaterInitial()) {
    on<CheckBetaConfirmationEvent>((event, emit) {
      final checkForBeta = appUpdaterUseCase.checkIsReceivingBeta.invoke();
      if (checkForBeta == null) {
        emit(AppUpdaterBetaCheck());
      }
      add(CheckForUpdatesEvent());
    });

    on<CheckForUpdatesEvent>((event, emit) async {
      emit(AppUpdaterLoading());
      final data = await appUpdaterUseCase.checkUpdate.invoke();
      emit(AppUpdaterLoaded(data));
    });

    on<DownloadAPKEvent>((event, emit) {
      appUpdaterUseCase.downloadAPK.invoke();
    });
  }
}
