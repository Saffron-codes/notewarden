import 'package:note_warden/models/collection_model.dart';
import 'package:sqflite/sqflite.dart';

class CollectionService {
  final Database db;
  const CollectionService(this.db);


  Future<List<Collection>> loadCollections()async {
    final rawCollections = await db.query("Collection");
    return List<Collection>.from(rawCollections.map((model)=> Collection.fromJson(model)));
  }

  Future<Collection> addCollection({required String name}) async {

    DateTime dt = DateTime.now();
    
    final Map<String, dynamic> collectionJson = {
      'name': name,
      'createdAt': dt.toIso8601String(),
      'updatedAt': dt.toIso8601String(),
    };

    int id = await db.insert('Collection', collectionJson);

    print("INSERTED COLLECTION ID  : $id");

    collectionJson['id'] = id;

    if(id != 0){
      return Collection.fromJson(collectionJson);
    }
    else{
      throw Exception("Collection error");
    }
  }
}
