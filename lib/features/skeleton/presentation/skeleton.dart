import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_warden/features/feature_collection/domain/use_case/collection_usecase.dart';
import 'package:note_warden/features/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
import 'package:note_warden/features/feature_media/domain/use_case/media_use_case.dart';
import 'package:note_warden/features/feature_media/presentation/media_list/media_bloc/media_bloc.dart';
import 'package:note_warden/features/feature_settings/domain/use_case/settings_use_case.dart';
import 'package:note_warden/features/feature_settings/presentation/settings_cubit/settings_cubit.dart';
import 'package:note_warden/features/feature_settings/presentation/settings_cubit/settings_state.dart';
import 'package:note_warden/injection_container.dart';
import 'package:note_warden/router.dart';
import 'package:system_theme/system_theme.dart';

class NoteWardenWinApp extends StatelessWidget {
  const NoteWardenWinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CollectionsBloc(sl<CollectionUseCase>())
              ..add(GetCollections())),
        BlocProvider(create: (_) => SettingsCubit(sl<SettingsUseCase>(), sl())),
        BlocProvider(create: (_) => MediaBloc(sl<MediaUseCase>())),
      ],
      child: BlocBuilder<SettingsCubit, AppSettingsState>(
        builder: (context, state) {
          return FluentApp.router(
            title: "NoteWarden",
            debugShowCheckedModeBanner: false,
            theme: FluentThemeData(
              accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            ),
            darkTheme: FluentThemeData(
              brightness: Brightness.dark,
              accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            ),
            themeMode: state.themeMode,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
