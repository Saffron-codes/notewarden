part of 'app_updater_bloc.dart';

@immutable
sealed class AppUpdaterEvent {}

class CheckForUpdatesEvent extends AppUpdaterEvent {}

class CheckBetaConfirmationEvent extends AppUpdaterEvent {}

class DownloadAPKEvent extends AppUpdaterEvent {}
