import "package:get_it/get_it.dart";
import "package:note_warden/services/collection_service.dart";
import "package:note_warden/services/media_service.dart";
import "package:sqflite/sqflite.dart";

import "services/database_service.dart";

GetIt sl = GetIt.instance;

Future<void> init()async{

  DatabaseHelper dbHelper = DatabaseHelper();
  Database db = await dbHelper.database;

  sl.registerSingleton<Database>(db);

  sl.registerLazySingleton(() => CollectionService(sl<Database>()));

  sl.registerLazySingleton(() => MediaService(sl<Database>()));
  
}