import 'package:flutter/material.dart';
import 'package:note_warden/services/cache_service.dart';
import 'package:note_warden/utils/enums.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsProvider extends ChangeNotifier {
  CacheService cacheService;
  PackageInfo packageInfo;

  SettingsProvider({required this.cacheService, required this.packageInfo}) {
    _init();
  }

  ThemeMode _themeMode = ThemeMode.system;

  ListOrder _listorder = ListOrder.byCreation;

  bool _isReceivingBetaUpdates = false;

  set themeMode(ThemeMode val) {
    cacheService.setData("theme", val.name);
    _themeMode = val;
    notifyListeners();
  }

  set listorder(ListOrder val) {
    cacheService.setData("listorder", val.name);
    _listorder = val;
    notifyListeners();
  }

  set isReceivingBetaUpdates(bool val) {
    cacheService.setBetaUpdatesOption(val);
    _isReceivingBetaUpdates = val;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;

  String get buildVersion => packageInfo.version;

  ListOrder get listorder => _listorder;

  bool get isReceivingBetaUpdates => _isReceivingBetaUpdates;

  String getListOrder() {
    if (_listorder == ListOrder.byCreation) {
      return "By time of creation";
    } else {
      return "By time of modification";
    }
  }

  void _init() {
    final val = cacheService.getData('theme');
    final listorder = cacheService.getData('listorder');
    _isReceivingBetaUpdates = cacheService.isReceivingBeta() ?? false;
    notifyListeners();
    if (val.isNotEmpty) {
      if (val == "system") {
        _themeMode = ThemeMode.system;
        notifyListeners();
      } else if (val == "dark") {
        _themeMode = ThemeMode.dark;
        notifyListeners();
      } else {
        _themeMode = ThemeMode.light;
        notifyListeners();
      }
    } else {
      _themeMode = ThemeMode.system;
      notifyListeners();
    }
    if (listorder.isNotEmpty) {
      if (listorder == "byCreation") {
        _listorder = ListOrder.byCreation;
        notifyListeners();
      } else {
        _listorder = ListOrder.byModification;
        notifyListeners();
      }
    }
  }
}
