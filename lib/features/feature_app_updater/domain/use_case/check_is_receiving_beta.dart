import 'package:note_warden/features/feature_app_updater/domain/repository/app_updater_repository.dart';

class CheckIsReceivingBeta {
  final AppUpdaterRepository appUpdaterRepository;

  const CheckIsReceivingBeta(this.appUpdaterRepository);
  bool? invoke() {
    return appUpdaterRepository.isReceivingBeta();
  }
}
