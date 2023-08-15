import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";
import "package:get_it/get_it.dart";
import "package:note_warden/services/app_updater.dart";
import "package:note_warden/services/cache_service.dart";
import "package:note_warden/services/collection_service.dart";
import "package:note_warden/services/file_picker_service.dart";
import "package:note_warden/services/media_service.dart";
import "package:note_warden/services/report_service.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sqflite/sqflite.dart";
import 'package:http/http.dart' as http;
import "firebase_options.dart";
import "services/database_service.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
GetIt sl = GetIt.instance;

Future<void> init() async {
  // Initialze .env file for firebase credentials
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DatabaseHelper dbHelper = DatabaseHelper();
  Database db = await dbHelper.database;

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // Injecting Dependencies

  sl.registerSingleton<Database>(db);

  sl.registerSingleton<FirebaseFirestore>(firestore);

  sl.registerLazySingleton(() => CollectionService(sl<Database>()));

  sl.registerLazySingleton(() => MediaService(sl<Database>()));

  sl.registerLazySingleton(() => FilePickerService());

  sl.registerLazySingleton(() => CacheService(sl<SharedPreferences>()));

  sl.registerLazySingleton(() => AppUpdater(sl<http.Client>(), sl<PackageInfo>().version));

  sl.registerLazySingleton(() => ReportService(firestore: sl<FirebaseFirestore>(),packageInfo: sl<PackageInfo>()));

  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerSingleton<PackageInfo>(packageInfo);

  sl.registerSingleton<http.Client>(http.Client());
}
