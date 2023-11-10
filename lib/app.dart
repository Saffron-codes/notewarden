// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:note_warden/injection_container.dart';
// import 'package:note_warden/feature_app_updater/presentation/app_updater_bloc/app_updater_bloc.dart';
// import 'package:note_warden/feature_collection/domain/use_case/collection_usecase.dart';
// import 'package:note_warden/feature_collection/domain/use_case/search_collection.dart';
// import 'package:note_warden/feature_collection/presentation/collection_search/collection_search_bloc/collection_search_bloc.dart';
// import 'package:note_warden/feature_collection/presentation/collections/collections_bloc/collections_bloc.dart';
// import 'package:note_warden/feature_collection/presentation/collections/collections_view.dart';
// import 'package:note_warden/feature_media/domain/use_case/media_use_case.dart';
// import 'package:note_warden/feature_media/presentation/media_list/media_bloc/media_bloc.dart';
// import 'package:note_warden/feature_media/presentation/media_list/media_list.dart';
// import 'package:note_warden/feature_report/presentation/pages/submit_report_view.dart';
// import 'package:note_warden/feature_report/presentation/report_cubit/report_cubit.dart';
// import 'package:note_warden/feature_settings/domain/use_case/settings_use_case.dart';
// import 'package:note_warden/feature_settings/presentation/pages/settings_view.dart';
// import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_cubit.dart';
// import 'package:note_warden/feature_settings/presentation/settings_cubit/settings_state.dart';

// import 'feature_media/presentation/media_detailed/media_detailed_view.dart';
// import 'feature_media/presentation/pdf_preview/pdf_preview.dart';

// class AppBloc extends StatelessWidget {
//   const AppBloc({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         // BlocProvider(create: (_) => ReceiveMediaCubit()),
//         BlocProvider(
//             create: (_) => CollectionsBloc(sl<CollectionUseCase>())
//               ..add(GetCollections())),
//         BlocProvider(
//             create: (_) => CollectionSearchBloc(sl<SearchCollection>())),
//         BlocProvider(create: (_) => MediaBloc(sl<MediaUseCase>())),
//         BlocProvider(create: (_) => SettingsCubit(sl<SettingsUseCase>(), sl())),
//         BlocProvider(create: (_) => ReportCubit(sl())),
//         BlocProvider(
//             create: (_) =>
//                 AppUpdaterBloc(sl())..add(CheckBetaConfirmationEvent()))
//       ],
//       child: BlocBuilder<SettingsCubit, AppSettingsState>(
//         builder: (context, state) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             initialRoute: "/collection",
//             themeMode: state.themeMode,
//             theme: ThemeData.light(useMaterial3: true),
//             darkTheme: ThemeData.dark(useMaterial3: true),
//             routes: {
//               // "/": (context) => ReceiveMediaView(
//               //       rootContext: context,
//               //     ),
//               "/media": (context) => MediaList(),
//               "/media/detailed": (context) => MediaDetailedView(),
//               "/media/pdf": (context) => PDFPreview(),
//               // "/media/confirm_media": (context) => ConfirmMediaView(),
//               "/collection": (context) => CollectionScreen(),
//               "/settings": (context) => SettingsView(),
//               "/report": (context) => SubmitReportView()
//             },
//           );
//         },
//       ),
//     );
//   }
// }
