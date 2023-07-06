import "package:get_it/get_it.dart";
import "package:note_warden/services/cache_service.dart";
import "package:note_warden/services/collection_service.dart";
import "package:note_warden/services/file_picker_service.dart";
import "package:note_warden/services/media_service.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sqflite/sqflite.dart";

import "services/database_service.dart";

GetIt sl = GetIt.instance;

Future<void> init()async{

  DatabaseHelper dbHelper = DatabaseHelper();
  Database db = await dbHelper.database;
  
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  sl.registerSingleton<Database>(db);

  sl.registerLazySingleton(() => CollectionService(sl<Database>()));

  sl.registerLazySingleton(() => MediaService(sl<Database>()));

  sl.registerLazySingleton(() => FilePickerService());

  sl.registerLazySingleton(() => CacheService(sl<SharedPreferences>()));

  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  
  sl.registerSingleton<PackageInfo>(packageInfo);
  
}