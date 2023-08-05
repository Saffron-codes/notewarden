import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppUpdater {
  final http.Client httpclient;

  const AppUpdater(this.httpclient);

  void check() async {
    if(!kDebugMode){
      
    }
  }
}
