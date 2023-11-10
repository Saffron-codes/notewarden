import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:note_warden/core/data/database_helper.dart';
import 'package:note_warden/features/feature_app_updater/data/data_source/app_updater_data_source.dart';
import 'package:note_warden/features/feature_app_updater/data/repository/app_updater_repository_impl.dart';
import 'package:note_warden/features/feature_app_updater/domain/repository/app_updater_repository.dart';
import 'package:note_warden/features/feature_app_updater/domain/use_case/app_updater_use_case.dart';
import 'package:note_warden/features/feature_app_updater/domain/use_case/check_is_receiving_beta.dart';
import 'package:note_warden/features/feature_app_updater/domain/use_case/check_update.dart';
import 'package:note_warden/features/feature_app_updater/domain/use_case/download_apk.dart';
import 'package:note_warden/features/feature_media/data/data_source/media_data_source.dart';
import 'package:note_warden/features/feature_media/domain/use_case/delete_media.dart';
import 'package:note_warden/features/feature_media/domain/use_case/get_media_list.dart';
import 'package:note_warden/features/feature_media/domain/use_case/insert_media.dart';
import 'package:note_warden/features/feature_media/domain/use_case/media_use_case.dart';
import 'package:note_warden/features/feature_settings/data/data_source/settings_data_source.dart';
import 'package:note_warden/features/feature_settings/domain/use_case/get_app_settings.dart';
import 'package:note_warden/features/feature_settings/domain/use_case/set_app_settings.dart';
import 'package:note_warden/features/feature_settings/domain/use_case/settings_use_case.dart';
import 'package:note_warden/features/feature_collection/domain/use_case/add_collection.dart';
import 'package:note_warden/features/feature_collection/domain/use_case/get_collections.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'features/feature_collection/data/data_source/collection_datasource.dart';
import 'features/feature_collection/data/repository/collection_repository_impl.dart';
import 'features/feature_collection/domain/repository/collection_repository.dart';
import 'features/feature_collection/domain/use_case/collection_usecase.dart';
import 'features/feature_collection/domain/use_case/delete_collection.dart';
import 'features/feature_collection/domain/use_case/search_collection.dart';
import 'features/feature_media/data/repository/media_repository_impl.dart';
import 'features/feature_media/domain/repository/media_repository.dart';
import 'features/feature_settings/data/repository/settings_repository_impl.dart';
import 'features/feature_settings/domain/repository/settings_repository.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Initialze .env file for firebase credentials
  await dotenv.load(fileName: ".env");
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  DatabaseHelper dbHelper = DatabaseHelper();
  Database db = await dbHelper.database;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  sl.registerSingleton<Database>(db);

  sl.registerFactory(() => sharedPreferences);
  sl.registerFactory(() => packageInfo);
  // sl.registerFactory(() => firestore);

  // Data sources
  sl.registerLazySingleton<CollectionDataSource>(
      () => CollectionDataSourceImpl(db));

  sl.registerLazySingleton<SettingsDataSource>(
      () => SettingsDataSourceImpl(sl()));

  sl.registerLazySingleton<MediaDataSource>(() => MediaDataSourceImpl(db));

  // sl.registerLazySingleton<ReportDataSource>(
  //     () => ReportDataSourceImpl(sl(), sl()));

  sl.registerLazySingleton<AppUpdaterDataSource>(
      () => AppUpdaterDataSourceImpl(sl(), sl(), sl()));

  // Repositories
  sl.registerLazySingleton<CollectionRepository>(
      () => CollectionRepositoryImpl(sl<CollectionDataSource>()));

  sl.registerLazySingleton<MediaRepository>(
      () => MediaRepositoryImpl(sl<MediaDataSource>()));

  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(sl()));

  // sl.registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl(sl()));

  sl.registerLazySingleton<AppUpdaterRepository>(
      () => AppUpdaterRepositoryImpl(sl()));

  // Feature based Usecases
  sl.registerLazySingleton<CollectionUseCase>(
    () => CollectionUseCase(sl<GetCollections>(), sl<AddCollection>(),
        sl<DeleteCollection>(), sl<SearchCollection>()),
  );

  sl.registerLazySingleton<MediaUseCase>(
    () =>
        MediaUseCase(sl<GetMediaList>(), sl<InsertMedia>(), sl<DeleteMedia>()),
  );

  sl.registerLazySingleton<SettingsUseCase>(() => SettingsUseCase(sl(), sl()));

  sl.registerLazySingleton(() => AppUpdaterUseCase(sl(), sl(), sl()));

  // Individual Usecases
  sl.registerLazySingleton<GetCollections>(
      () => GetCollections(sl<CollectionRepository>()));
  sl.registerLazySingleton<AddCollection>(
      () => AddCollection(sl<CollectionRepository>()));
  sl.registerLazySingleton<DeleteCollection>(
      () => DeleteCollection(sl<CollectionRepository>()));

  sl.registerLazySingleton<SearchCollection>(
      () => SearchCollection(sl<CollectionRepository>()));

  sl.registerLazySingleton<GetMediaList>(
      () => GetMediaList(sl<MediaRepository>()));

  sl.registerLazySingleton<InsertMedia>(
      () => InsertMedia(sl<MediaRepository>()));

  sl.registerLazySingleton<DeleteMedia>(
      () => DeleteMedia(sl<MediaRepository>()));

  sl.registerLazySingleton(() => GetAppSettings(sl()));
  sl.registerLazySingleton(() => SetAppSettings(sl()));

  // sl.registerLazySingleton(() => SubmitReport(sl()));

  sl.registerLazySingleton(() => CheckIsReceivingBeta(sl()));
  sl.registerLazySingleton(() => CheckUpdate(sl()));
  sl.registerLazySingleton(() => DownloadAPK(sl()));

  sl.registerFactory<http.Client>(() => http.Client());
}
