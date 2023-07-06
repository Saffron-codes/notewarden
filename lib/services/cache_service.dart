import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  final SharedPreferences prefs;

  const CacheService(this.prefs);

  void setData(String key,String val)async{
    await prefs.setString(key, val);
  }

  String getData(String key){
    return prefs.getString(key) ?? "";
  }
}