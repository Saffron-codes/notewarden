part of 'app_updater_bloc.dart';

@immutable
sealed class AppUpdaterState {}

final class AppUpdaterInitial extends AppUpdaterState {}

final class AppUpdaterLoading extends AppUpdaterState {}

final class AppUpdaterLoaded extends AppUpdaterState {
  final AppUpdateInfo appUpdateInfo;
  AppUpdaterLoaded(this.appUpdateInfo);
}

final class AppUpdaterBetaCheck extends AppUpdaterState {}
